#using script_340a2e805e35f7a2;
#using script_471b31bd963b388e;
#using script_75da5547b1822294;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace item_supply_drop;

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x6
// Checksum 0x8b5f9bc4, Offset: 0x3e0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"item_supply_drop", &function_70a657d8, undefined, undefined, #"item_world");
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0xc4d3ab8e, Offset: 0x430
// Size: 0x10c
function private function_70a657d8() {
    if (!item_world_util::use_item_spawns()) {
        return;
    }
    level.item_supply_drops = [];
    level.var_3f771530 = [];
    /#
        level thread _setup_devgui();
    #/
    clientfield::register("scriptmover", "supply_drop_fx", 1, 1, "int");
    clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int");
    clientfield::register("scriptmover", "supply_drop_portal_fx", 1, 1, "int");
    clientfield::register("vehicle", "supply_drop_vehicle_landed", 1, 1, "counter");
}

/#

    // Namespace item_supply_drop/item_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0x7d791aaf, Offset: 0x548
    // Size: 0x3c6
    function private function_eaba72c9() {
        while (true) {
            if (getdvarint(#"wz_supply_drop", 0) > 0) {
                switch (getdvarint(#"wz_supply_drop", 0)) {
                case 1:
                    level thread function_418e26fe();
                    break;
                case 2:
                    vehicletypes = array(#"vehicle_t9_mil_ru_tank_t72");
                    level thread function_418e26fe(undefined, 1, 1, 0, 1, vehicletypes[randomint(vehicletypes.size)]);
                    break;
                }
                setdvar(#"wz_supply_drop", 0);
            }
            if (getdvarint(#"wz_flare_drop", 0) > 0) {
                switch (getdvarint(#"wz_flare_drop", 0)) {
                case 1:
                    level thread function_7d4a448f();
                    break;
                }
                setdvar(#"wz_flare_drop", 0);
            }
            if (getdvarint(#"hash_5dc24c61c66f6fee", 0) > 0) {
                debug_supply_drop();
            }
            if (getdvarint(#"hash_40d4ca5923d72b3d", 0) > 0) {
                players = getplayers();
                if (isdefined(players[0])) {
                    switch (getdvarint(#"hash_40d4ca5923d72b3d", 0)) {
                    case 1:
                        level thread drop_supply_drop(players[0].origin);
                        break;
                    case 2:
                        level thread drop_supply_drop(players[0].origin, 1, undefined, undefined, #"hash_27bac84003da7795");
                        break;
                    case 3:
                        vehicletypes = array(#"vehicle_t9_mil_ru_tank_t72");
                        level thread drop_supply_drop(players[0].origin, 1, 1, vehicletypes[randomint(vehicletypes.size)]);
                        break;
                    }
                }
                setdvar(#"hash_40d4ca5923d72b3d", 0);
            }
            waitframe(1);
        }
    }

    // Namespace item_supply_drop/item_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0x5182f99, Offset: 0x918
    // Size: 0x174
    function private _setup_devgui() {
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x90>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:xcf>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x110>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x152>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x1a3>");
        adddebugcommand("<dev string:x38>" + mapname + "<dev string:x1fa>");
        level thread function_eaba72c9();
    }

    // Namespace item_supply_drop/item_supply_drop
    // Params 0, eflags: 0x4
    // Checksum 0x4d903c9, Offset: 0xa98
    // Size: 0x45c
    function private debug_supply_drop() {
        if (isdefined(level.supplydropveh)) {
            deathcircleindex = isdefined(level.deathcircleindex) ? level.deathcircleindex : 0;
            deathcircle = level.deathcircles[deathcircleindex];
            nextdeathcircle = isdefined(level.deathcircles[deathcircleindex + 1]) ? level.deathcircles[deathcircleindex + 1] : deathcircle;
            height = nextdeathcircle.origin[2];
            radius = 200;
            sphere(level.var_d1c35a7a, radius, (1, 0, 0));
            sphere(level.var_ebe9f3de, radius, (1, 0, 0));
            if (isdefined(level.var_1b269b78)) {
                sphere(level.var_1b269b78, radius, (0, 1, 0));
                var_58d00116 = (level.var_1b269b78[0], level.var_1b269b78[1], height);
                line(level.var_1b269b78, var_58d00116, (0, 1, 0));
                sphere(var_58d00116, radius, (0, 1, 0));
            }
            if (isdefined(level.var_538928e3)) {
                sphere(level.var_538928e3, radius, (0, 1, 0));
                var_fb4d4118 = (level.var_538928e3[0], level.var_538928e3[1], height);
                line(level.var_538928e3, var_fb4d4118, (0, 1, 0));
                sphere(var_fb4d4118, radius, (0, 1, 0));
            }
            sphere(level.var_daa6e3f, radius, (1, 0.5, 0));
            for (index = 1; index < level.var_57e06aea.size; index++) {
                line(level.var_57e06aea[index - 1], level.var_57e06aea[index], (1, 0, 0));
            }
            if (isdefined(level.supplydropmax) && isdefined(level.supplydropmin)) {
                mintop = level.supplydropmin;
                var_9c1af46d = (level.supplydropmin[0], level.supplydropmax[1], level.supplydropmax[2]);
                var_c46271bf = (level.supplydropmax[0], level.supplydropmin[1], level.supplydropmin[2]);
                var_99a8be82 = level.supplydropmax;
                line(mintop, var_9c1af46d, (1, 1, 1));
                line(mintop, var_c46271bf, (1, 1, 1));
                line(var_99a8be82, var_9c1af46d, (1, 1, 1));
                line(var_99a8be82, var_c46271bf, (1, 1, 1));
                sphere(mintop, radius, (1, 1, 1));
                sphere(var_c46271bf, radius, (1, 1, 1));
                sphere(var_9c1af46d, radius, (1, 1, 1));
                sphere(var_99a8be82, radius, (1, 1, 1));
            }
        }
    }

#/

// Namespace item_supply_drop/item_supply_drop
// Params 2, eflags: 0x5 linked
// Checksum 0xe286843f, Offset: 0xf00
// Size: 0x424
function private function_c7bd0aa8(point, startpoint) {
    assert(isvec(point));
    assert(isvec(startpoint));
    if (function_16bbdd8b(point)) {
        return point;
    }
    assert(function_16bbdd8b(startpoint));
    if (territory::function_c0de0601()) {
        var_bb96e272 = vectornormalize(startpoint - point);
        pathlength = distance2d(startpoint, point);
        var_28021cac = int(pathlength / 1000);
        for (var_c742cad6 = 1; var_c742cad6 <= var_28021cac; var_c742cad6++) {
            newpoint = startpoint + var_bb96e272 * 1000 * var_c742cad6;
            if (function_16bbdd8b(newpoint)) {
                return newpoint;
            }
        }
        return point;
    }
    min = level.supplydropmin;
    max = level.supplydropmax;
    var_1ccbeeaa = (point[0], point[1], 0);
    var_49e5fac9 = (startpoint[0], startpoint[1], 0);
    if (var_1ccbeeaa[0] < min[0]) {
        toend = vectornormalize(var_1ccbeeaa - var_49e5fac9);
        assert(toend[0] != 0);
        t = (min[0] - var_49e5fac9[0]) / toend[0];
        var_1ccbeeaa = var_49e5fac9 + toend * t;
    } else if (var_1ccbeeaa[0] > max[0]) {
        toend = vectornormalize(var_1ccbeeaa - var_49e5fac9);
        assert(toend[0] != 0);
        t = (max[0] - var_49e5fac9[0]) / toend[0];
        var_1ccbeeaa = var_49e5fac9 + toend * t;
    }
    if (var_1ccbeeaa[1] < min[1]) {
        toend = vectornormalize(var_1ccbeeaa - var_49e5fac9);
        assert(toend[1] != 0);
        t = (min[1] - var_49e5fac9[1]) / toend[1];
        var_1ccbeeaa = var_49e5fac9 + toend * t;
    } else if (var_1ccbeeaa[1] > max[1]) {
        toend = vectornormalize(var_1ccbeeaa - var_49e5fac9);
        assert(toend[1] != 0);
        t = (max[1] - var_49e5fac9[1]) / toend[1];
        var_1ccbeeaa = var_49e5fac9 + toend * t;
    }
    point = (var_1ccbeeaa[0], var_1ccbeeaa[1], point[2]);
    return point;
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0xcb654c58, Offset: 0x1330
// Size: 0x44
function private function_9ae8f99e() {
    self endon(#"death");
    self waittill(#"veh_landed");
    clientfield::increment("supply_drop_vehicle_landed");
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0xf3de4607, Offset: 0x1380
// Size: 0x1cc
function private function_13339b58() {
    self endon(#"death");
    self animscripted("parachute_open", self.origin, self.angles, #"hash_4f2b2f1b4df13119", "normal", "root", 1, 0);
    self waittill(#"parachute_open");
    if (!is_true(self.parachute_close)) {
        self animscripted("parachute_idle", self.origin, self.angles, #"hash_39265b4ed372175a", "normal", "root", 1, 0);
    }
    self waittill(#"parachute_close");
    self unlink();
    self animscripted("parachute_closed", self.origin, self.angles, #"hash_32ad963f25f115d2", "normal", "root", 1, 0);
    animlength = getanimlength("parachute_closed");
    wait animlength * 0.35;
    self clientfield::set("supply_drop_parachute_rob", 0);
    wait animlength * 0.65;
    self delete();
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x8c86d6f5, Offset: 0x1558
// Size: 0x2a
function private function_71c31c8d() {
    self notify(#"pop_parachute");
    if (isdefined(self)) {
        self.pop_parachute = 1;
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 3, eflags: 0x5 linked
// Checksum 0xd3de320d, Offset: 0x1590
// Size: 0x59c
function private function_500a6615(itemspawnlist = #"t9_supply_drop_stash_parent", var_93fe96a6 = 0, s_instance) {
    if (isdefined(self.supplydrop)) {
        supplydrop = self.supplydrop;
        self.supplydrop = undefined;
        supplydrop.supplydropveh = undefined;
        if (isdefined(supplydrop.var_d5552131)) {
            supplydrop.var_d5552131.supplydropveh = undefined;
        }
        supplydrop endon(#"death");
        supplydrop unlink();
        supplydrop show();
        supplydrop.angles = (0, supplydrop.angles[1], 0);
        startpoint = (supplydrop.origin[0], supplydrop.origin[1], min(10000, supplydrop.origin[2] - 200));
        endpoint = (supplydrop.origin[0], supplydrop.origin[1], -10000);
        travelspeed = is_true(supplydrop.var_abd32694) ? 400 : 200;
        groundoffset = is_true(supplydrop.var_abd32694) ? 200 : 60;
        groundtrace = physicstraceex(startpoint, endpoint, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), supplydrop, 32);
        groundpoint = groundtrace[#"position"] + (0, 0, groundoffset);
        traveldistance = startpoint - groundpoint;
        movetime = traveldistance[2] / travelspeed;
        if (movetime < 0) {
            movetime = 1;
        }
        supplydrop moveto(groundpoint, movetime);
        supplydrop playsound("evt_supply_drop");
        var_f6dfa3da = is_true(supplydrop.var_abd32694) ? 0.25 : 1;
        wait var_f6dfa3da;
        supplydropparachute = spawn("script_model", (0, 0, 0));
        supplydropparachute.targetname = "supply_drop_chute";
        supplydropparachute.origin = supplydrop.origin;
        supplydropparachute.angles = supplydrop.angles;
        supplydropparachute setforcenocull();
        supplydropparachute setmodel("p8_fxanim_wz_parachute_supplydrop_fade");
        supplydropparachute clientfield::set("supply_drop_parachute_rob", 1);
        supplydropparachute useanimtree("generic");
        supplydropparachute linkto(supplydrop, "tag_origin", (0, 0, 0));
        supplydropparachute thread function_13339b58();
        if (!is_true(supplydrop.pop_parachute)) {
            supplydrop waittill(#"movedone", #"pop_parachute");
        }
        if (isdefined(supplydropparachute)) {
            supplydropparachute notify(#"parachute_close");
            supplydropparachute.parachute_close = 1;
        }
        if (is_true(supplydrop.var_abd32694)) {
            if (isdefined(supplydrop.var_d5552131)) {
                supplydrop.var_d5552131 unlink();
                supplydrop.var_d5552131.overridevehicledamage = undefined;
                callback::callback(#"hash_740a58650e79dbfd", supplydrop.var_d5552131);
                if (isdefined(level.var_cd8f416a)) {
                    level.var_cd8f416a[level.var_cd8f416a.size] = supplydrop.var_d5552131;
                }
                supplydrop.var_d5552131 thread function_9ae8f99e();
            }
            supplydrop delete();
            return;
        }
        supplydrop physicslaunch();
        supplydrop thread function_924a11ff(itemspawnlist, var_93fe96a6, s_instance);
        supplydrop thread function_e21ceb1b();
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x84884351, Offset: 0x1b38
// Size: 0x1fc
function private function_e21ceb1b() {
    self endon(#"death", #"movedone");
    extendbounds = (10, 10, 10);
    previousorigin = self.origin;
    while (true) {
        var_3769eb50 = getentitiesinradius(self.origin, 128, 1);
        var_15d21979 = abs((previousorigin - self.origin)[2]);
        if (var_15d21979 > 4) {
            foreach (player in var_3769eb50) {
                if (isalive(player) && player istouching(self, extendbounds)) {
                    player dodamage(player.health + 1, player.origin, self, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
                    player playsound("evt_supply_crush");
                }
            }
        }
        previousorigin = self.origin;
        waitframe(1);
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x87b51b63, Offset: 0x1d40
// Size: 0x1fc
function private function_ba3be344() {
    self endon(#"death");
    self notify(#"emergency_exit");
    exitangle = 60;
    right = anglestoforward(self.angles + (0, exitangle, 0));
    left = anglestoforward(self.angles + (0, exitangle * -1, 0));
    var_7a66fccd = function_43e35f94();
    startpoint = self.origin;
    leftpoint = function_c7bd0aa8(startpoint + left * var_7a66fccd, startpoint);
    rightpoint = function_c7bd0aa8(startpoint + right * var_7a66fccd, startpoint);
    endpoint = rightpoint;
    if (distance2d(startpoint, leftpoint) < distance2d(startpoint, rightpoint)) {
        endpoint = leftpoint;
    }
    var_57e06aea = function_eafcba42(startpoint, endpoint);
    self.var_57e06aea = var_57e06aea;
    self setspeed(50);
    wait 0.5;
    self thread function_c2edbefb(var_57e06aea);
    wait 0.5;
    self setspeed(100);
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x8e35f940, Offset: 0x1f48
// Size: 0x90
function private function_3c597e8d() {
    if (territory::function_c0de0601()) {
        return territory::get_center();
    }
    var_6024133d = getentarray("map_corner", "targetname");
    if (var_6024133d.size) {
        return math::find_box_center(var_6024133d[0].origin, var_6024133d[1].origin);
    }
    return (0, 0, 0);
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0xef2019cb, Offset: 0x1fe0
// Size: 0x10e
function private function_43e35f94() {
    if (territory::function_c0de0601()) {
        return territory::get_radius();
    }
    var_6024133d = getentarray("map_corner", "targetname");
    if (var_6024133d.size) {
        x = abs(var_6024133d[0].origin[0] - var_6024133d[1].origin[0]);
        y = abs(var_6024133d[0].origin[1] - var_6024133d[1].origin[1]);
        return (max(x, y) / 2);
    }
    return 1000;
}

// Namespace item_supply_drop/item_supply_drop
// Params 1, eflags: 0x5 linked
// Checksum 0x8bd8e10e, Offset: 0x20f8
// Size: 0x152
function private function_67d7d040(var_d91c179d) {
    supplydrop = spawn("script_model", (0, 0, 0));
    supplydrop.targetname = "supply_drop";
    supplydrop setmodel("wpn_t9_streak_care_package_friendly_world_nosight");
    supplydrop setforcenocull();
    supplydrop useanimtree("generic");
    supplydrop.var_a64ed253 = 1;
    supplydrop.var_bad13452 = 0;
    supplydrop.targetname = supplydrop getentitynumber() + "_stash_" + randomint(2147483647);
    supplydrop clientfield::set("dynamic_stash", 1);
    supplydrop clientfield::set("dynamic_stash_type", 1);
    supplydrop.stash_type = 1;
    supplydrop.supplydropveh = var_d91c179d;
    return supplydrop;
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x98eedf72, Offset: 0x2258
// Size: 0x128
function private function_546afbb6() {
    self endon(#"death");
    var_dc66f988 = self getvelocity();
    var_2497a956 = 0;
    while (true) {
        velocity = self getvelocity();
        var_2497a956 = min(var_2497a956, velocity[2]);
        if (abs(velocity[2] - var_dc66f988[2]) > 100) {
            if (abs(var_2497a956) > 1000) {
                self setvehvelocity((0, 0, 0));
                self dodamage(self.health, self.origin, self);
            }
            return;
        }
        waitframe(1);
        var_dc66f988 = velocity;
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 2, eflags: 0x5 linked
// Checksum 0x166d5b0c, Offset: 0x2388
// Size: 0x1fc
function private function_a3832aa0(var_d91c179d, vehicletype) {
    supplydrop = spawn("script_model", (0, 0, -64000));
    supplydrop setmodel("tag_origin");
    supplydrop useanimtree("generic");
    supplydrop.supplydropveh = var_d91c179d;
    var_d5552131 = spawnvehicle(vehicletype, (0, 0, 0), (0, 0, 0));
    if (!isdefined(var_d5552131)) {
        supplydrop delete();
        return;
    }
    var_d5552131 linkto(supplydrop, "tag_origin", (0, 0, 0), (0, 90, 0));
    var_d5552131.var_b9b5403c = var_d5552131.health * 0.5;
    var_d5552131.overridevehicledamage = &function_9a275b1f;
    var_d5552131.supplydropveh = var_d91c179d;
    var_d5552131.supplydrop = supplydrop;
    var_d5552131 makeusable();
    if (is_true(var_d5552131.isphysicsvehicle)) {
        var_d5552131 setbrake(1);
    }
    supplydrop.var_d5552131 = var_d5552131;
    supplydrop.var_abd32694 = 1;
    arrayremovevalue(level.var_3f771530, undefined);
    level.var_3f771530[level.var_3f771530.size] = var_d5552131;
    return supplydrop;
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x49693478, Offset: 0x2590
// Size: 0x208
function private function_6eb3f7bb() {
    if (!isdefined(level.supplydropmin) || !isdefined(level.supplydropmax)) {
        var_6024133d = getentarray("map_corner", "targetname");
        if (var_6024133d.size) {
            minx = min(var_6024133d[0].origin[0], var_6024133d[1].origin[0]);
            miny = min(var_6024133d[0].origin[1], var_6024133d[1].origin[1]);
            minz = -10;
            level.supplydropmin = (minx, miny, minz);
            maxx = max(var_6024133d[0].origin[0], var_6024133d[1].origin[0]);
            maxy = max(var_6024133d[0].origin[1], var_6024133d[1].origin[1]);
            maxz = 10;
            level.supplydropmax = (maxx, maxy, maxz);
            return;
        }
        level.supplydropmin = level.mapcenter - (1000, 1000, 10);
        level.supplydropmax = level.mapcenter + (1000, 1000, 10);
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 1, eflags: 0x5 linked
// Checksum 0x602f1af0, Offset: 0x27a0
// Size: 0xa2
function private function_16bbdd8b(point) {
    if (territory::function_c0de0601()) {
        testpoint = (point[0], point[1], point[2]);
        return territory::is_inside(testpoint, 1);
    }
    function_6eb3f7bb();
    testpoint = (point[0], point[1], 0);
    return function_fc3f770b(level.supplydropmin, level.supplydropmax, testpoint);
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x0
// Checksum 0xd552af8b, Offset: 0x2850
// Size: 0x10e
function function_186f5ca3() {
    function_6eb3f7bb();
    for (index = 0; index < 10; index++) {
        droppoint = (randomfloatrange(level.supplydropmin[0], level.supplydropmax[0]), randomfloatrange(level.supplydropmin[1], level.supplydropmax[1]), randomfloatrange(level.supplydropmin[2], level.supplydropmax[2]));
        if (!oob::chr_party(droppoint)) {
            if (isdefined(function_9cc082d2(droppoint, 15000))) {
                return droppoint;
            }
        }
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 15, eflags: 0x5 linked
// Checksum 0xb34351f1, Offset: 0x2968
// Size: 0xe2
function private function_415bdb1d(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    if (max(self.health - vsurfacenormal, 0) <= self.var_b9b5403c) {
        self thread function_500a6615();
        self thread function_ba3be344();
        self.var_b9b5403c = 0;
    }
    return vsurfacenormal;
}

// Namespace item_supply_drop/item_supply_drop
// Params 15, eflags: 0x5 linked
// Checksum 0x9affbc2e, Offset: 0x2a58
// Size: 0x182
function private function_9a275b1f(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    newhealth = max(self.health - vsurfacenormal, 0);
    if (newhealth <= self.var_b9b5403c) {
        if (isdefined(self.supplydropveh)) {
            supplydropveh = self.supplydropveh;
            supplydropveh thread function_500a6615();
            supplydropveh thread function_ba3be344();
        } else {
            if (isdefined(self.supplydrop)) {
                self.supplydrop function_71c31c8d();
                self thread function_546afbb6();
            }
            self.var_b9b5403c = 0;
        }
    }
    if (newhealth <= 0) {
        self unlink();
        self.health = vsurfacenormal + 1;
    }
    return vsurfacenormal;
}

// Namespace item_supply_drop/item_supply_drop
// Params 5, eflags: 0x5 linked
// Checksum 0x65f18bcc, Offset: 0x2be8
// Size: 0x1f4
function private function_eafcba42(startpoint, endpoint, droppoint, maxheight, minheight) {
    points = [];
    startpoint = trace_point(startpoint);
    endpoint = trace_point(endpoint);
    var_bb96e272 = vectornormalize(endpoint - startpoint);
    pathlength = distance2d(startpoint, endpoint);
    var_28021cac = int(pathlength / 5000);
    points[0] = startpoint;
    if (isdefined(droppoint)) {
        var_66d25ef4 = distancesquared(startpoint, droppoint);
    }
    for (var_c742cad6 = 1; var_c742cad6 <= var_28021cac; var_c742cad6++) {
        var_a1bc57e1 = startpoint + var_bb96e272 * 5000 * var_c742cad6;
        if (isdefined(droppoint)) {
            if (distancesquared(startpoint, var_a1bc57e1) >= var_66d25ef4 && distancesquared(startpoint, points[points.size - 1]) <= var_66d25ef4) {
                points[points.size] = droppoint;
            }
        }
        points[points.size] = trace_point(var_a1bc57e1, undefined, maxheight, minheight);
        waitframe(1);
    }
    points[points.size] = endpoint;
    return points;
}

// Namespace item_supply_drop/item_supply_drop
// Params 4, eflags: 0x5 linked
// Checksum 0xd99fb8e, Offset: 0x2de8
// Size: 0x144
function private trace_point(point, var_5fd22b95 = 1, maxheight = 10000, minheight = 5000) {
    startpoint = (point[0], point[1], maxheight);
    endpoint = (point[0], point[1], minheight);
    trace = groundtrace(startpoint, endpoint, 0, undefined, var_5fd22b95);
    if (!var_5fd22b95) {
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
// Params 2, eflags: 0x5 linked
// Checksum 0xebaa53bd, Offset: 0x2f38
// Size: 0x104
function private function_8234217e(var_faa1ea31, vectors) {
    assert(vectors.size > 0);
    var_54b25053 = vectors[0];
    bestdot = vectordot(var_54b25053, var_faa1ea31);
    for (index = 1; index < vectors.size; index++) {
        var_7aa67ca6 = vectordot(vectors[index], var_faa1ea31);
        if (abs(var_7aa67ca6) > abs(bestdot)) {
            var_54b25053 = vectors[index];
            bestdot = var_7aa67ca6;
        }
    }
    if (bestdot < 0) {
        var_54b25053 *= -1;
    }
    return var_54b25053;
}

// Namespace item_supply_drop/item_supply_drop
// Params 1, eflags: 0x5 linked
// Checksum 0x63fa6dba, Offset: 0x3048
// Size: 0xfa
function private function_a40836e(angles) {
    axises = [];
    axises[axises.size] = anglestoforward(angles);
    axises[axises.size] = anglestoright(angles);
    axises[axises.size] = anglestoup(angles);
    var_553ec518 = (1, 0, 0);
    worldup = (0, 0, 1);
    newforward = function_8234217e(var_553ec518, axises);
    newup = function_8234217e(worldup, axises);
    newangles = axistoangles(newforward, newup);
    return newangles;
}

// Namespace item_supply_drop/item_supply_drop
// Params 1, eflags: 0x1 linked
// Checksum 0xc6588cdd, Offset: 0x3150
// Size: 0x22
function function_ee19f0b0(angles) {
    return function_a40836e(angles);
}

// Namespace item_supply_drop/item_supply_drop
// Params 3, eflags: 0x5 linked
// Checksum 0x150a303d, Offset: 0x3180
// Size: 0x1d4
function private function_924a11ff(itemspawnlist, var_93fe96a6 = 0, s_instance) {
    assert(isdefined(itemspawnlist));
    self endon(#"death");
    self thread item_drop::function_10ececeb(1, 80, 24, (-25, -25, 0), (25, 25, 50));
    self waittill(#"stationary");
    if (isdefined(level.var_a16ff74d)) {
        self thread [[ level.var_a16ff74d ]](var_93fe96a6, s_instance);
        return;
    }
    var_e68facee = isdefined(self getlinkedent());
    self clientfield::set("supply_drop_fx", 1);
    if (!item_world_util::function_74e1e547(self.origin)) {
        self delete();
        return;
    }
    self setmodel("wpn_t9_streak_care_package_friendly_world_nosight");
    self.anglesoffset = (0, 90, 0);
    items = self namespace_65181344::function_5eada592(itemspawnlist, 1);
    wait 60;
    if (isdefined(self)) {
        self clientfield::set("supply_drop_fx", 0);
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x394eb260, Offset: 0x3360
// Size: 0x3c
function private function_9e8348e4() {
    self waittill(#"hash_7b6fafe066e13e0b", #"death");
    self thread function_500a6615();
}

// Namespace item_supply_drop/item_supply_drop
// Params 4, eflags: 0x5 linked
// Checksum 0xc1e95546, Offset: 0x33a8
// Size: 0x1fc
function private function_c2edbefb(path, droppoint, var_86928932 = 1, var_2118f785 = undefined) {
    self endon(#"death", #"emergency_exit");
    for (pathindex = 1; pathindex < path.size; pathindex++) {
        var_f155e743 = 0;
        if (isdefined(droppoint)) {
            var_f155e743 = distancesquared(path[pathindex], droppoint) < function_a3f6cdac(128);
        }
        self function_a57c34b7(path[pathindex], var_f155e743 && var_86928932, 0);
        while (true) {
            if (var_f155e743) {
                if (distancesquared(droppoint, self.origin) < function_a3f6cdac(128)) {
                    if (var_86928932) {
                        wait 2;
                    }
                    self thread function_500a6615(var_2118f785);
                    if (var_86928932) {
                        wait 1;
                    }
                    break;
                }
            } else if (distancesquared(path[pathindex], self.origin) < function_a3f6cdac(1500)) {
                break;
            }
            waitframe(1);
        }
    }
    self notify(#"hash_7b6fafe066e13e0b");
    self delete();
}

// Namespace item_supply_drop/item_supply_drop
// Params 5, eflags: 0x5 linked
// Checksum 0xf4a3beee, Offset: 0x35b0
// Size: 0x324
function private function_261b0e67(spawnpoint, endpoint, droppoint, dropflare = 1, vehicleoverride = undefined) {
    var_47736ddd = array(spawnpoint, droppoint, endpoint);
    var_7366c0ff = spawnvehicle(isdefined(vehicleoverride) ? vehicleoverride : "vehicle_t8_mil_helicopter_transport_dark_wz_infiltration", spawnpoint, vectortoangles(vectornormalize(endpoint - spawnpoint)));
    if (!isdefined(var_7366c0ff)) {
        return;
    }
    var_7366c0ff endon(#"death");
    var_7366c0ff setforcenocull();
    var_7366c0ff.goalradius = 128;
    var_7366c0ff.goalheight = 128;
    var_7366c0ff.health = 10000;
    var_7366c0ff setspeed(125);
    var_7366c0ff setrotorspeed(1);
    var_7366c0ff vehicle::toggle_tread_fx(1);
    var_7366c0ff vehicle::toggle_exhaust_fx(1);
    var_7366c0ff vehicle::toggle_sounds(1);
    for (pathindex = 1; pathindex < var_47736ddd.size; pathindex++) {
        var_f155e743 = 0;
        if (isdefined(droppoint)) {
            var_f155e743 = distancesquared(var_47736ddd[pathindex], droppoint) < function_a3f6cdac(128);
        }
        var_7366c0ff function_a57c34b7(var_47736ddd[pathindex], 0, 0);
        while (true) {
            if (var_f155e743) {
                if (distancesquared(droppoint, var_7366c0ff.origin) < function_a3f6cdac(128)) {
                    if (dropflare) {
                        fx = playfx("wz/fx8_death_circle_cue", var_7366c0ff.origin, (1, 0, 0), (0, 0, 1));
                    }
                    break;
                }
            } else if (distancesquared(var_47736ddd[pathindex], var_7366c0ff.origin) < function_a3f6cdac(1500)) {
                break;
            }
            waitframe(1);
        }
    }
    var_7366c0ff delete();
}

// Namespace item_supply_drop/item_supply_drop
// Params 1, eflags: 0x0
// Checksum 0x2f826953, Offset: 0x38e0
// Size: 0x5cc
function function_7d4a448f(var_47d17dcb = 0) {
    if (!is_true(level.deathcircle.enabled)) {
        return;
    }
    if (!isdefined(level.deathcircles) || level.deathcircles.size <= 0) {
        return;
    }
    deathcircleindex = isdefined(level.deathcircleindex) ? level.deathcircleindex : 0;
    deathcircle = level.deathcircles[deathcircleindex];
    nextdeathcircle = isdefined(level.deathcircles[deathcircleindex + 1]) ? level.deathcircles[deathcircleindex + 1] : deathcircle;
    if (var_47d17dcb) {
        nextdeathcircle = level.deathcircles[level.deathcircles.size - 1];
    }
    var_94f13d8b = 18000;
    deathcirclecenter = nextdeathcircle.origin;
    deathcirclecenter = (deathcirclecenter[0], deathcirclecenter[1], var_94f13d8b);
    var_4f59c30d = nextdeathcircle.radius;
    if (!function_16bbdd8b(deathcirclecenter)) {
        return;
    }
    var_396cbf6e = deathcircle.radius;
    var_be734526 = deathcircle.radius - var_4f59c30d;
    if (var_be734526 > 0) {
        dirtocenter = vectornormalize(deathcirclecenter - (deathcircle.origin[0], deathcircle.origin[1], var_94f13d8b));
        var_8df04549 = deathcirclecenter - dirtocenter * var_4f59c30d;
        exitpoint = deathcirclecenter + dirtocenter * var_4f59c30d;
    } else {
        degrees = randomint(360);
        var_8df04549 = (cos(degrees) * var_4f59c30d, sin(degrees) * var_4f59c30d, 0) + deathcirclecenter;
        exitpoint = (cos(degrees) * -1 * var_4f59c30d, sin(degrees) * -1 * var_4f59c30d, 0) + deathcirclecenter;
    }
    waitframe(1);
    droppoint = deathcirclecenter;
    var_8df04549 = function_c7bd0aa8(var_8df04549, droppoint);
    exitpoint = function_c7bd0aa8(exitpoint, droppoint);
    var_bb96e272 = vectornormalize(exitpoint - var_8df04549);
    var_142db926 = 5000;
    var_a2712870 = distance2d(deathcircle.origin, deathcirclecenter);
    var_6eae2ffb = var_396cbf6e + var_a2712870 + var_142db926;
    var_429b69c0 = max(var_6eae2ffb, 15000);
    var_e9e24bda = max(var_396cbf6e, 45000);
    spawnpoint = var_8df04549 - var_bb96e272 * var_429b69c0;
    spawnpoint = function_c7bd0aa8(spawnpoint, droppoint);
    endpoint = exitpoint + var_bb96e272 * var_e9e24bda;
    endpoint = function_c7bd0aa8(endpoint, droppoint);
    level thread function_261b0e67(spawnpoint, endpoint, droppoint, 1);
    angles = vectortoangles(var_bb96e272);
    rightoffset = vectornormalize(anglestoright(angles)) * 1024;
    leftoffset = rightoffset * -1;
    var_ae85ee87 = var_bb96e272 * -1024;
    vehicleoverride = undefined;
    offset = rightoffset + var_ae85ee87 + (0, 0, randomintrange(25, 50));
    level thread function_261b0e67(spawnpoint + offset, endpoint + offset, droppoint + offset, 0, vehicleoverride);
    offset = leftoffset + var_ae85ee87 + (0, 0, randomintrange(-50, -25));
    level thread function_261b0e67(spawnpoint + offset, endpoint + offset, droppoint + offset, 0, vehicleoverride);
}

// Namespace item_supply_drop/item_supply_drop
// Params 6, eflags: 0x0
// Checksum 0x61de2a54, Offset: 0x3eb8
// Size: 0x5cc
function function_418e26fe(var_2118f785 = undefined, helicopter = 0, voiceevent = 1, var_541c190b = 0, var_d6388d1 = 0, vehicletype = undefined) {
    if (!is_true(level.deathcircle.enabled)) {
        return;
    }
    if (!isdefined(level.deathcircles) || level.deathcircles.size <= 0) {
        return;
    }
    var_f5f2246e = helicopter ? 10000 : 35000;
    deathcircleindex = isdefined(level.deathcircleindex) ? level.deathcircleindex : 0;
    deathcircle = level.deathcircles[deathcircleindex];
    nextdeathcircle = isdefined(level.deathcircles[deathcircleindex + 1]) ? level.deathcircles[deathcircleindex + 1] : deathcircle;
    if (helicopter) {
        var_729c4495 = 5000;
    } else {
        var_729c4495 = 20000;
    }
    var_729c4495 += var_541c190b;
    var_94f13d8b = 2000 + var_729c4495;
    deathcirclecenter = nextdeathcircle.origin;
    deathcirclecenter = (deathcirclecenter[0], deathcirclecenter[1], var_94f13d8b);
    var_4f59c30d = nextdeathcircle.radius;
    if (!function_16bbdd8b(deathcirclecenter)) {
        return;
    }
    var_396cbf6e = deathcircle.radius;
    var_be734526 = deathcircle.radius - var_4f59c30d;
    degrees = randomint(360);
    var_8df04549 = (cos(degrees) * var_4f59c30d, sin(degrees) * var_4f59c30d, var_94f13d8b) + deathcirclecenter;
    exitpoint = (cos(degrees) * -1 * var_4f59c30d, sin(degrees) * -1 * var_4f59c30d, var_94f13d8b) + deathcirclecenter;
    waitframe(1);
    var_e2be9787 = 10;
    droppoint = undefined;
    for (index = 0; index < var_e2be9787; index++) {
        randompoint = lerpvector(var_8df04549, exitpoint, randomfloatrange(0, 1));
        if (function_16bbdd8b(randompoint)) {
            droppoint = trace_point(randompoint, 0, undefined, -5000);
            if (isdefined(droppoint) && !oob::chr_party(droppoint)) {
                droppoint = trace_point(randompoint, 0, var_f5f2246e, var_729c4495);
                break;
            }
        }
        waitframe(1);
    }
    if (!isdefined(droppoint)) {
        return;
    }
    var_8df04549 = function_c7bd0aa8(var_8df04549, droppoint);
    var_8df04549 = trace_point(var_8df04549, undefined, var_f5f2246e, var_729c4495);
    exitpoint = function_c7bd0aa8(exitpoint, droppoint);
    exitpoint = trace_point(exitpoint, undefined, var_f5f2246e, var_729c4495);
    var_bb96e272 = vectornormalize(exitpoint - var_8df04549);
    var_429b69c0 = max(var_396cbf6e, 15000);
    var_e9e24bda = max(var_396cbf6e, 45000);
    spawnpoint = var_8df04549 - var_bb96e272 * var_429b69c0;
    spawnpoint = function_c7bd0aa8(spawnpoint, droppoint);
    endpoint = exitpoint + var_bb96e272 * var_e9e24bda;
    endpoint = function_c7bd0aa8(endpoint, droppoint);
    if (helicopter) {
        var_57e06aea = function_47ec98c4(spawnpoint, endpoint, droppoint, var_d6388d1, vehicletype, var_f5f2246e, var_729c4495);
    } else {
        var_57e06aea = function_b8dd1978(spawnpoint, endpoint, droppoint, var_2118f785, voiceevent);
    }
    level.var_1b269b78 = var_8df04549;
    level.var_538928e3 = exitpoint;
}

// Namespace item_supply_drop/item_supply_drop
// Params 5, eflags: 0x1 linked
// Checksum 0xad00f7b8, Offset: 0x4490
// Size: 0x29c
function function_b8dd1978(startpoint, endpoint, droppoint, var_2118f785 = undefined, voiceevent = 1) {
    var_57e06aea = array(startpoint, droppoint, endpoint);
    supplydropveh = spawnvehicle("vehicle_t8_mil_air_transport_infiltration", startpoint, vectortoangles(vectornormalize(endpoint - startpoint)));
    if (!isdefined(supplydropveh)) {
        return;
    }
    supplydropveh setforcenocull();
    if (voiceevent) {
        callback::callback(#"hash_40cd438036ae13df", undefined);
    }
    supplydropveh.goalradius = 128;
    supplydropveh.goalheight = 128;
    supplydropveh.var_57e06aea = var_57e06aea;
    supplydropveh.maxhealth = supplydropveh.health;
    supplydropveh.var_b9b5403c = supplydropveh.maxhealth * 0.5;
    supplydropveh setspeed(100);
    supplydropveh setrotorspeed(1);
    supplydropveh vehicle::toggle_tread_fx(1);
    supplydropveh vehicle::toggle_exhaust_fx(1);
    supplydropveh vehicle::toggle_sounds(1);
    supplydropveh.var_5d0810d7 = 1;
    supplydrop = function_67d7d040(supplydropveh);
    if (!isdefined(supplydropveh)) {
        return;
    }
    supplydrop linkto(supplydropveh, "tag_origin", (0, 0, -120));
    supplydropveh.supplydrop = supplydrop;
    supplydropveh thread function_c2edbefb(var_57e06aea, droppoint, 0, var_2118f785);
    supplydropveh thread function_9e8348e4();
    level.item_supply_drops[level.item_supply_drops.size] = supplydrop;
    return var_57e06aea;
}

// Namespace item_supply_drop/item_supply_drop
// Params 8, eflags: 0x1 linked
// Checksum 0x673dbab8, Offset: 0x4738
// Size: 0x41c
function function_47ec98c4(startpoint, endpoint, droppoint, var_d91c179d = 0, vehicletype = undefined, maxheight = undefined, minheight = undefined, var_2118f785) {
    if (is_true(var_d91c179d) && !isdefined(vehicletype)) {
        return;
    }
    var_57e06aea = function_eafcba42(startpoint, endpoint, droppoint, maxheight, minheight);
    assert(var_57e06aea.size >= 2);
    startpoint = var_57e06aea[0];
    endpoint = var_57e06aea[var_57e06aea.size - 1];
    if (!var_d91c179d) {
        supplydropveh = spawnvehicle("vehicle_t9_mil_helicopter_care_package", startpoint, vectortoangles(vectornormalize(endpoint - startpoint)));
    } else {
        supplydropveh = spawnvehicle("vehicle_t9_mil_ru_heli_transport_vehicle_drop", startpoint, vectortoangles(vectornormalize(endpoint - startpoint)));
    }
    if (!isdefined(supplydropveh)) {
        return;
    }
    supplydropveh setforcenocull();
    callback::callback(#"hash_40cd438036ae13df", vehicletype);
    supplydropveh.takedamage = 0;
    supplydropveh.goalradius = 128;
    supplydropveh.goalheight = 128;
    supplydropveh.var_57e06aea = var_57e06aea;
    supplydropveh.maxhealth = supplydropveh.health;
    supplydropveh.var_b9b5403c = supplydropveh.maxhealth * 0.5;
    supplydropveh.overridevehicledamage = &function_415bdb1d;
    supplydropveh setspeed(100);
    supplydropveh setrotorspeed(1);
    supplydropveh vehicle::toggle_tread_fx(1);
    supplydropveh vehicle::toggle_exhaust_fx(1);
    supplydropveh vehicle::toggle_sounds(1);
    supplydropveh.var_5d0810d7 = 1;
    if (var_d91c179d) {
        supplydrop = function_a3832aa0(supplydropveh, vehicletype);
    } else {
        supplydrop = function_67d7d040(supplydropveh);
    }
    supplydrop linkto(supplydropveh, "tag_cargo_attach", (0, 0, -45));
    supplydropveh.supplydrop = supplydrop;
    supplydropveh thread function_c2edbefb(var_57e06aea, droppoint, undefined, var_2118f785);
    supplydropveh thread function_9e8348e4();
    level.item_supply_drops[level.item_supply_drops.size] = supplydrop;
    level.supplydrop = supplydrop;
    level.supplydropveh = supplydropveh;
    level.var_57e06aea = var_57e06aea;
    level.var_daa6e3f = droppoint;
    level.var_d1c35a7a = startpoint;
    level.var_ebe9f3de = endpoint;
    return var_57e06aea;
}

// Namespace item_supply_drop/item_supply_drop
// Params 5, eflags: 0x0
// Checksum 0x978cb45c, Offset: 0x4b60
// Size: 0x2f6
function drop_supply_drop(droppoint, helicopter = 0, var_d6388d1 = 0, vehicletype = undefined, var_2118f785) {
    assert(isvec(droppoint));
    if (!function_16bbdd8b(droppoint)) {
        return;
    }
    maxheight = helicopter ? 10000 : 35000;
    minheight = helicopter ? 5000 : 20000;
    droppoint = trace_point(droppoint, 0, maxheight, minheight);
    if (!isdefined(droppoint) || !function_16bbdd8b(droppoint)) {
        return;
    }
    mapcenter = function_3c597e8d();
    var_7a66fccd = function_43e35f94();
    if (var_7a66fccd == 0) {
        var_7a66fccd = 10000;
    }
    var_b98da7dd = droppoint - mapcenter;
    var_b98da7dd = (var_b98da7dd[0], var_b98da7dd[1], 0);
    var_b98da7dd = vectornormalize(var_b98da7dd);
    spawnpoint = mapcenter + var_b98da7dd * var_7a66fccd;
    spawnpoint = (spawnpoint[0], spawnpoint[1], droppoint[2]);
    if (!territory::function_c0de0601()) {
        spawnpoint = function_c7bd0aa8(spawnpoint, droppoint);
    }
    endpoint = mapcenter - var_b98da7dd * var_7a66fccd;
    endpoint = (endpoint[0], endpoint[1], droppoint[2]);
    if (!territory::function_c0de0601()) {
        endpoint = function_c7bd0aa8(endpoint, droppoint);
    }
    if (distance2dsquared(spawnpoint, endpoint) <= function_a3f6cdac(100)) {
        return;
    }
    if (helicopter) {
        var_57e06aea = function_47ec98c4(spawnpoint, endpoint, droppoint, var_d6388d1, vehicletype, undefined, undefined, var_2118f785);
        return;
    }
    var_57e06aea = function_b8dd1978(spawnpoint, endpoint, droppoint, var_2118f785);
}

// Namespace item_supply_drop/item_supply_drop
// Params 2, eflags: 0x0
// Checksum 0xbd52517e, Offset: 0x4e60
// Size: 0x88
function spawn_supply_drop(spawnpoint, itemspawnlist) {
    supplydrop = function_67d7d040(undefined);
    supplydrop.origin = spawnpoint;
    struct = spawnstruct();
    struct.supplydrop = supplydrop;
    struct thread function_500a6615(itemspawnlist);
    return supplydrop;
}

// Namespace item_supply_drop/item_supply_drop
// Params 4, eflags: 0x1 linked
// Checksum 0x65058524, Offset: 0x4ef0
// Size: 0xf0
function function_9771c7db(spawnpoint, itemspawnlist, var_93fe96a6 = 0, s_instance) {
    supplydrop = function_67d7d040(undefined);
    supplydrop.origin = spawnpoint;
    struct = spawnstruct();
    if (isdefined(level.var_183bdb80)) {
        supplydrop thread [[ level.var_183bdb80 ]](s_instance);
    } else {
        supplydrop thread supply_drop_portal_fx();
    }
    supplydrop.struct = struct;
    struct.supplydrop = supplydrop;
    struct thread function_500a6615(itemspawnlist, var_93fe96a6, s_instance);
    return supplydrop;
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x1 linked
// Checksum 0xe4ecfed8, Offset: 0x4fe8
// Size: 0x4c
function supply_drop_portal_fx() {
    self clientfield::set("supply_drop_portal_fx", 1);
    wait 3;
    self clientfield::set("supply_drop_portal_fx", 0);
}

