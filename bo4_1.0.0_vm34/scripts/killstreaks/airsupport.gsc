#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\weapons\weapons;

#namespace airsupport;

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xf1d985ec, Offset: 0x188
// Size: 0x1e4
function init_shared() {
    if (!isdefined(level.var_4743b6c0)) {
        level.var_4743b6c0 = {};
        if (!isdefined(level.airsupportheightscale)) {
            level.airsupportheightscale = 1;
        }
        level.airsupportheightscale = getdvarint(#"scr_airsupportheightscale", level.airsupportheightscale);
        level.noflyzones = [];
        level.noflyzones = getentarray("no_fly_zone", "targetname");
        airsupport_heights = struct::get_array("air_support_height", "targetname");
        /#
            if (airsupport_heights.size > 1) {
                util::error("<dev string:x30>");
            }
        #/
        airsupport_heights = getentarray("air_support_height", "targetname");
        /#
            if (airsupport_heights.size > 0) {
                util::error("<dev string:x6c>");
            }
        #/
        heli_height_meshes = getentarray("heli_height_lock", "classname");
        /#
            if (heli_height_meshes.size > 1) {
                util::error("<dev string:xcf>");
            }
        #/
        callback::on_spawned(&clearmonitoredspeed);
        callback::on_finalize_initialization(&function_6567e2dd);
    }
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x945fce3c, Offset: 0x378
// Size: 0x1e
function function_6567e2dd() {
    profilestart();
    initrotatingrig();
    profilestop();
}

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0x57412215, Offset: 0x3a0
// Size: 0x134
function function_4293d951(location, usedcallback, killstreakname) {
    self notify(#"used");
    waitframe(1);
    if (isdefined(usedcallback)) {
        killstreak_id = -1;
        if (isdefined(killstreakname)) {
            params = level.killstreakbundle[killstreakname];
            team = self.team;
            killstreak_id = self killstreakrules::killstreakstart(killstreakname, team, 0, 1);
            if (killstreak_id == -1) {
                return 0;
            }
            if (isdefined(level.var_a58f156)) {
                self [[ level.var_a58f156 ]](killstreakname, team, killstreak_id);
            }
            self stats::function_4f10b697(params.ksweapon, #"used", 1);
        }
        return self [[ usedcallback ]](location, killstreak_id);
    }
    return 1;
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xd3ac2dcd, Offset: 0x4e0
// Size: 0x7e
function endselectionongameend() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"cancel_location");
    self endon(#"used");
    self endon(#"host_migration_begin");
    level waittill(#"game_ended");
    self notify(#"game_ended");
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x9ca32441, Offset: 0x568
// Size: 0x7e
function endselectiononhostmigration() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"cancel_location");
    self endon(#"used");
    self endon(#"game_ended");
    level waittill(#"host_migration_begin");
    self notify(#"cancel_location");
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x6f14b79c, Offset: 0x5f0
// Size: 0x1ae
function endselectionthink() {
    assert(isplayer(self));
    assert(isalive(self));
    assert(isdefined(self.selectinglocation));
    assert(self.selectinglocation == 1);
    self thread endselectionongameend();
    self thread endselectiononhostmigration();
    event = self waittill(#"death", #"disconnect", #"cancel_location", #"game_ended", #"used", #"weapon_change", #"emp_jammed");
    if (event._notify != "disconnect") {
        self.selectinglocation = undefined;
        self thread clearuplocationselection();
    }
    if (event._notify != "used") {
        self notify(#"confirm_location");
    }
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xdafd3123, Offset: 0x7a8
// Size: 0xb4
function clearuplocationselection() {
    event = self waittill(#"death", #"disconnect", #"game_ended", #"used", #"weapon_change", #"emp_jammed", #"weapon_change_complete");
    if (event._notify != "disconnect") {
        self endlocationselection();
    }
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0xb6b1a6f8, Offset: 0x868
// Size: 0x3c
function stoploopsoundaftertime(time) {
    self endon(#"death");
    wait time;
    self stoploopsound(2);
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0xc96761a1, Offset: 0x8b0
// Size: 0x6a
function calculatefalltime(flyheight) {
    gravity = getdvarint(#"bg_gravity", 0);
    time = sqrt(2 * flyheight / gravity);
    return time;
}

// Namespace airsupport/airsupport
// Params 4, eflags: 0x0
// Checksum 0x5ca48d51, Offset: 0x928
// Size: 0x8a
function calculatereleasetime(flytime, flyheight, flyspeed, bombspeedscale) {
    falltime = calculatefalltime(flyheight);
    bomb_x = flyspeed * bombspeedscale * falltime;
    release_time = bomb_x / flyspeed;
    return flytime * 0.5 - release_time;
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xb981a15, Offset: 0x9c0
// Size: 0x118
function getminimumflyheight() {
    airsupport_height = struct::get("air_support_height", "targetname");
    if (isdefined(airsupport_height)) {
        planeflyheight = airsupport_height.origin[2];
    } else {
        println("<dev string:x10b>");
        planeflyheight = 850;
        if (isdefined(level.airsupportheightscale)) {
            level.airsupportheightscale = getdvarint(#"scr_airsupportheightscale", level.airsupportheightscale);
            planeflyheight *= getdvarint(#"scr_airsupportheightscale", level.airsupportheightscale);
        }
        if (isdefined(level.forceairsupportmapheight)) {
            planeflyheight += level.forceairsupportmapheight;
        }
    }
    return planeflyheight;
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0x8ebf0c63, Offset: 0xae0
// Size: 0x3c4
function callstrike(flightplan) {
    level.bomberdamagedents = [];
    level.bomberdamagedentscount = 0;
    level.bomberdamagedentsindex = 0;
    assert(flightplan.distance != 0, "<dev string:x15a>");
    planehalfdistance = flightplan.distance / 2;
    path = getstrikepath(flightplan.target, flightplan.height, planehalfdistance);
    startpoint = path[#"start"];
    endpoint = path[#"end"];
    flightplan.height = path[#"height"];
    direction = path[#"direction"];
    d = length(startpoint - endpoint);
    flytime = d / flightplan.speed;
    bombtime = calculatereleasetime(flytime, flightplan.height, flightplan.speed, flightplan.bombspeedscale);
    if (bombtime < 0) {
        bombtime = 0;
    }
    assert(flytime > bombtime);
    flightplan.owner endon(#"disconnect");
    requireddeathcount = flightplan.owner.deathcount;
    side = vectorcross(anglestoforward(direction), (0, 0, 1));
    plane_seperation = 25;
    side_offset = vectorscale(side, plane_seperation);
    level thread planestrike(flightplan.owner, requireddeathcount, startpoint, endpoint, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
    wait flightplan.planespacing;
    level thread planestrike(flightplan.owner, requireddeathcount, startpoint + side_offset, endpoint + side_offset, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
    wait flightplan.planespacing;
    side_offset = vectorscale(side, -1 * plane_seperation);
    level thread planestrike(flightplan.owner, requireddeathcount, startpoint + side_offset, endpoint + side_offset, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
}

// Namespace airsupport/airsupport
// Params 10, eflags: 0x0
// Checksum 0x22ca69bd, Offset: 0xeb0
// Size: 0x174
function planestrike(owner, requireddeathcount, pathstart, pathend, bombtime, flytime, flyspeed, bombspeedscale, direction, planespawnedfunction) {
    if (!isdefined(owner)) {
        return;
    }
    plane = spawn("script_model", pathstart);
    plane.angles = direction;
    plane.team = owner.team;
    plane setowner(owner);
    plane moveto(pathend, flytime, 0, 0);
    /#
        thread debug_plane_line(flytime, flyspeed, pathstart, pathend);
    #/
    if (isdefined(planespawnedfunction)) {
        plane [[ planespawnedfunction ]](owner, requireddeathcount, pathstart, pathend, bombtime, bombspeedscale, flytime, flyspeed);
    }
    wait flytime;
    plane notify(#"delete");
    plane delete();
}

// Namespace airsupport/airsupport
// Params 2, eflags: 0x0
// Checksum 0xb5ffa175, Offset: 0x1030
// Size: 0x90
function determinegroundpoint(player, position) {
    ground = (position[0], position[1], player.origin[2]);
    trace = bullettrace(ground + (0, 0, 10000), ground, 0, undefined);
    return trace[#"position"];
}

// Namespace airsupport/airsupport
// Params 2, eflags: 0x0
// Checksum 0x9535e770, Offset: 0x10c8
// Size: 0x4a
function determinetargetpoint(player, position) {
    point = determinegroundpoint(player, position);
    return clamptarget(point);
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xe9777180, Offset: 0x1120
// Size: 0x1a
function getmintargetheight() {
    return level.spawnmins[2] - 500;
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xe729b608, Offset: 0x1148
// Size: 0x1a
function getmaxtargetheight() {
    return level.spawnmaxs[2] + 500;
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0x31243e2c, Offset: 0x1170
// Size: 0x8e
function clamptarget(target) {
    min = getmintargetheight();
    max = getmaxtargetheight();
    if (target[2] < min) {
        target[2] = min;
    }
    if (target[2] > max) {
        target[2] = max;
    }
    return target;
}

// Namespace airsupport/airsupport
// Params 4, eflags: 0x0
// Checksum 0x4cc4d122, Offset: 0x1208
// Size: 0x82
function _insidecylinder(point, base, radius, height) {
    if (isdefined(height)) {
        if (point[2] > base[2] + height) {
            return false;
        }
    }
    dist = distance2d(point, base);
    if (dist < radius) {
        return true;
    }
    return false;
}

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0x4d018a73, Offset: 0x1298
// Size: 0x8a
function _insidenoflyzonebyindex(point, index, disregardheight) {
    height = level.noflyzones[index].height;
    if (isdefined(disregardheight)) {
        height = undefined;
    }
    return _insidecylinder(point, level.noflyzones[index].origin, level.noflyzones[index].radius, height);
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0x45da5388, Offset: 0x1330
// Size: 0xe8
function getnoflyzoneheight(point) {
    height = point[2];
    origin = undefined;
    for (i = 0; i < level.noflyzones.size; i++) {
        if (_insidenoflyzonebyindex(point, i)) {
            if (height < level.noflyzones[i].height) {
                height = level.noflyzones[i].height;
                origin = level.noflyzones[i].origin;
            }
        }
    }
    if (!isdefined(origin)) {
        return point[2];
    }
    return origin[2] + height;
}

// Namespace airsupport/airsupport
// Params 2, eflags: 0x0
// Checksum 0xd0a63918, Offset: 0x1420
// Size: 0x86
function insidenoflyzones(point, disregardheight) {
    noflyzones = [];
    for (i = 0; i < level.noflyzones.size; i++) {
        if (_insidenoflyzonebyindex(point, i, disregardheight)) {
            noflyzones[noflyzones.size] = i;
        }
    }
    return noflyzones;
}

// Namespace airsupport/airsupport
// Params 2, eflags: 0x0
// Checksum 0xaf8f29f8, Offset: 0x14b0
// Size: 0x13c
function crossesnoflyzone(start, end) {
    for (i = 0; i < level.noflyzones.size; i++) {
        point = math::closest_point_on_line(level.noflyzones[i].origin + (0, 0, 0.5 * level.noflyzones[i].height), start, end);
        dist = distance2d(point, level.noflyzones[i].origin);
        if (point[2] > level.noflyzones[i].origin[2] + level.noflyzones[i].height) {
            continue;
        }
        if (dist < level.noflyzones[i].radius) {
            return i;
        }
    }
    return undefined;
}

// Namespace airsupport/airsupport
// Params 2, eflags: 0x0
// Checksum 0x1a7d22de, Offset: 0x15f8
// Size: 0x132
function crossesnoflyzones(start, end) {
    zones = [];
    for (i = 0; i < level.noflyzones.size; i++) {
        point = math::closest_point_on_line(level.noflyzones[i].origin, start, end);
        dist = distance2d(point, level.noflyzones[i].origin);
        if (point[2] > level.noflyzones[i].origin[2] + level.noflyzones[i].height) {
            continue;
        }
        if (dist < level.noflyzones[i].radius) {
            zones[zones.size] = i;
        }
    }
    return zones;
}

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0x2a205603, Offset: 0x1738
// Size: 0x114
function getnoflyzoneheightcrossed(start, end, minheight) {
    height = minheight;
    for (i = 0; i < level.noflyzones.size; i++) {
        point = math::closest_point_on_line(level.noflyzones[i].origin, start, end);
        dist = distance2d(point, level.noflyzones[i].origin);
        if (dist < level.noflyzones[i].radius) {
            if (height < level.noflyzones[i].height) {
                height = level.noflyzones[i].height;
            }
        }
    }
    return height;
}

// Namespace airsupport/airsupport
// Params 2, eflags: 0x0
// Checksum 0x888a9adb, Offset: 0x1858
// Size: 0x76
function _shouldignorenoflyzone(noflyzone, noflyzones) {
    if (!isdefined(noflyzone)) {
        return true;
    }
    for (i = 0; i < noflyzones.size; i++) {
        if (isdefined(noflyzones[i]) && noflyzones[i] == noflyzone) {
            return true;
        }
    }
    return false;
}

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0x715f1e2d, Offset: 0x18d8
// Size: 0x6e
function _shouldignorestartgoalnoflyzone(noflyzone, startnoflyzones, goalnoflyzones) {
    if (!isdefined(noflyzone)) {
        return true;
    }
    if (_shouldignorenoflyzone(noflyzone, startnoflyzones)) {
        return true;
    }
    if (_shouldignorenoflyzone(noflyzone, goalnoflyzones)) {
        return true;
    }
    return false;
}

// Namespace airsupport/airsupport
// Params 2, eflags: 0x0
// Checksum 0x4c37c6d0, Offset: 0x1950
// Size: 0x110
function gethelipath(start, goal) {
    startnoflyzones = insidenoflyzones(start, 1);
    /#
        thread debug_line(start, goal, (1, 1, 1));
    #/
    goalnoflyzones = insidenoflyzones(goal);
    if (goalnoflyzones.size) {
        goal = (goal[0], goal[1], getnoflyzoneheight(goal));
    }
    goal_points = calculatepath(start, goal, startnoflyzones, goalnoflyzones);
    if (!isdefined(goal_points)) {
        return undefined;
    }
    assert(goal_points.size >= 1);
    return goal_points;
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0x870434cc, Offset: 0x1a68
// Size: 0x94
function function_f597be8(goalorigin) {
    self endon(#"death");
    self endon(#"hash_41aaa8d75d168e0a");
    while (true) {
        distsq = distancesquared(self.origin, goalorigin);
        if (distsq <= 10000) {
            self notify(#"fallback_goal");
            break;
        }
        waitframe(1);
    }
}

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0x986f5968, Offset: 0x1b08
// Size: 0x1b4
function function_b7f54e75(var_6b71008, path, stopatgoal) {
    self endon(#"death");
    self endon(#"hash_78e76e8d9370e349");
    if (var_6b71008) {
        while (true) {
            var_6f7637e2 = ispointinnavvolume(self.origin, "navvolume_big");
            if (var_6f7637e2) {
                if (!issentient(self)) {
                    self makesentient();
                }
                break;
            }
            waitframe(1);
        }
        self setgoal(path[0], 1, stopatgoal);
        self function_3c8dce03(path[0], stopatgoal, 1);
        return;
    }
    if (issentient(self)) {
        while (true) {
            var_6f7637e2 = ispointinnavvolume(self.origin, "navvolume_big");
            if (!var_6f7637e2) {
                if (issentient(self)) {
                    self function_32aff240();
                }
                break;
            }
            waitframe(1);
        }
        self function_3c8dce03(path[0], stopatgoal, 0);
    }
}

// Namespace airsupport/airsupport
// Params 4, eflags: 0x0
// Checksum 0x13b57b8d, Offset: 0x1cc8
// Size: 0x286
function function_9eab754a(path, donenotify, stopatgoal, var_31b292c5) {
    self endon(#"death");
    var_6b71008 = 0;
    if (!ispointinnavvolume(path[0], "navvolume_big")) {
        if (issentient(self)) {
            self function_32aff240();
        }
        self function_3c8dce03(path[0], stopatgoal, 0);
    } else if (!ispointinnavvolume(self.origin, "navvolume_big")) {
        if (issentient(self)) {
            self function_32aff240();
        }
        self function_3c8dce03(path[0], stopatgoal, 0);
        var_6b71008 = 1;
    } else {
        self setgoal(path[0], 1, stopatgoal);
        self function_3c8dce03(path[0], stopatgoal, 1);
    }
    if (isdefined(var_31b292c5) && var_31b292c5) {
        self thread function_f597be8(path[0]);
    }
    self thread function_b7f54e75(var_6b71008, path, stopatgoal);
    /#
        thread debug_line(self.origin, path[0], (1, 1, 0));
    #/
    if (stopatgoal) {
        self waittill(#"goal", #"fallback_goal");
    } else {
        self waittill(#"near_goal", #"fallback_goal");
    }
    if (isdefined(donenotify)) {
        self notify(donenotify);
    }
    self notify(#"hash_41aaa8d75d168e0a");
    self notify(#"hash_78e76e8d9370e349");
}

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0xe3c672e4, Offset: 0x1f58
// Size: 0x152
function followpath(path, donenotify, stopatgoal) {
    self endon(#"death");
    for (i = 0; i < path.size - 1; i++) {
        self setgoal(path[i], 0);
        /#
            thread debug_line(self.origin, path[i], (1, 1, 0));
        #/
        self waittill(#"near_goal");
    }
    self setgoal(path[path.size - 1], stopatgoal);
    /#
        thread debug_line(self.origin, path[i], (1, 1, 0));
    #/
    if (stopatgoal) {
        self waittill(#"goal");
    } else {
        self waittill(#"near_goal");
    }
    if (isdefined(donenotify)) {
        self notify(donenotify);
    }
}

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0x992610da, Offset: 0x20b8
// Size: 0x94
function setgoalposition(goal, donenotify, stopatgoal = 1) {
    start = self.origin;
    goal_points = gethelipath(start, goal);
    if (!isdefined(goal_points)) {
        goal_points = [];
        goal_points[0] = goal;
    }
    followpath(goal_points, donenotify, stopatgoal);
}

// Namespace airsupport/airsupport
// Params 4, eflags: 0x0
// Checksum 0xbcc272be, Offset: 0x2158
// Size: 0x98
function clearpath(start, end, startnoflyzone, goalnoflyzone) {
    noflyzones = crossesnoflyzones(start, end);
    for (i = 0; i < noflyzones.size; i++) {
        if (!_shouldignorestartgoalnoflyzone(noflyzones[i], startnoflyzone, goalnoflyzone)) {
            return false;
        }
    }
    return true;
}

// Namespace airsupport/airsupport
// Params 2, eflags: 0x0
// Checksum 0xb110b7e0, Offset: 0x21f8
// Size: 0x52
function append_array(dst, src) {
    for (i = 0; i < src.size; i++) {
        dst[dst.size] = src[i];
    }
}

// Namespace airsupport/airsupport
// Params 6, eflags: 0x0
// Checksum 0x9a1edb0e, Offset: 0x2258
// Size: 0xf2
function calculatepath_r(start, end, points, startnoflyzones, goalnoflyzones, depth) {
    depth--;
    if (depth <= 0) {
        points[points.size] = end;
        return points;
    }
    noflyzones = crossesnoflyzones(start, end);
    for (i = 0; i < noflyzones.size; i++) {
        noflyzone = noflyzones[i];
        if (!_shouldignorestartgoalnoflyzone(noflyzone, startnoflyzones, goalnoflyzones)) {
            return undefined;
        }
    }
    points[points.size] = end;
    return points;
}

// Namespace airsupport/airsupport
// Params 4, eflags: 0x0
// Checksum 0xd861aeb1, Offset: 0x2358
// Size: 0x168
function calculatepath(start, end, startnoflyzones, goalnoflyzones) {
    points = [];
    points = calculatepath_r(start, end, points, startnoflyzones, goalnoflyzones, 3);
    if (!isdefined(points)) {
        return undefined;
    }
    assert(points.size >= 1);
    /#
        debug_sphere(points[points.size - 1], 10, (1, 0, 0), 1, 1000);
    #/
    point = start;
    for (i = 0; i < points.size; i++) {
        /#
            thread debug_line(point, points[i], (0, 1, 0));
            debug_sphere(points[i], 10, (0, 0, 1), 1, 1000);
        #/
        point = points[i];
    }
    return points;
}

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0xb83e023d, Offset: 0x24c8
// Size: 0x1ae
function _getstrikepathstartandend(goal, yaw, halfdistance) {
    direction = (0, yaw, 0);
    startpoint = goal + vectorscale(anglestoforward(direction), -1 * halfdistance);
    endpoint = goal + vectorscale(anglestoforward(direction), halfdistance);
    noflyzone = crossesnoflyzone(startpoint, endpoint);
    path = [];
    if (isdefined(noflyzone)) {
        path[#"noflyzone"] = noflyzone;
        startpoint = (startpoint[0], startpoint[1], level.noflyzones[noflyzone].origin[2] + level.noflyzones[noflyzone].height);
        endpoint = (endpoint[0], endpoint[1], startpoint[2]);
    } else {
        path[#"noflyzone"] = undefined;
    }
    path[#"start"] = startpoint;
    path[#"end"] = endpoint;
    path[#"direction"] = direction;
    return path;
}

// Namespace airsupport/airsupport
// Params 4, eflags: 0x0
// Checksum 0xf02c7244, Offset: 0x2680
// Size: 0x17e
function getstrikepath(target, height, halfdistance, yaw) {
    noflyzoneheight = getnoflyzoneheight(target);
    worldheight = target[2] + height;
    if (noflyzoneheight > worldheight) {
        worldheight = noflyzoneheight;
    }
    goal = (target[0], target[1], worldheight);
    path = [];
    if (!isdefined(yaw) || yaw != "random") {
        for (i = 0; i < 3; i++) {
            path = _getstrikepathstartandend(goal, randomint(360), halfdistance);
            if (!isdefined(path[#"noflyzone"])) {
                break;
            }
        }
    } else {
        path = _getstrikepathstartandend(goal, yaw, halfdistance);
    }
    path[#"height"] = worldheight - target[2];
    return path;
}

// Namespace airsupport/airsupport
// Params 5, eflags: 0x0
// Checksum 0xa5eed951, Offset: 0x2808
// Size: 0x74
function doglassdamage(pos, radius, max, min, mod) {
    wait randomfloatrange(0.05, 0.15);
    glassradiusdamage(pos, radius, max, min, mod);
}

// Namespace airsupport/airsupport
// Params 7, eflags: 0x0
// Checksum 0x916946b7, Offset: 0x2888
// Size: 0x402
function entlosradiusdamage(ent, pos, radius, max, min, owner, einflictor) {
    dist = distance(pos, ent.damagecenter);
    if (ent.isplayer || ent.isactor) {
        assumed_ceiling_height = 800;
        eye_position = ent.entity geteye();
        head_height = eye_position[2];
        debug_display_time = 4000;
        trace = weapons::damage_trace(ent.entity.origin, ent.entity.origin + (0, 0, assumed_ceiling_height), 0, undefined);
        indoors = trace[#"fraction"] != 1;
        if (indoors) {
            test_point = trace[#"position"];
            /#
                debug_star(test_point, (0, 1, 0), debug_display_time);
            #/
            trace = weapons::damage_trace((test_point[0], test_point[1], head_height), (pos[0], pos[1], head_height), 0, undefined);
            indoors = trace[#"fraction"] != 1;
            if (indoors) {
                /#
                    debug_star((pos[0], pos[1], head_height), (0, 1, 0), debug_display_time);
                #/
                dist *= 4;
                if (dist > radius) {
                    return false;
                }
            } else {
                /#
                    debug_star((pos[0], pos[1], head_height), (1, 0, 0), debug_display_time);
                #/
                trace = weapons::damage_trace((pos[0], pos[1], head_height), pos, 0, undefined);
                indoors = trace[#"fraction"] != 1;
                if (indoors) {
                    /#
                        debug_star(pos, (0, 1, 0), debug_display_time);
                    #/
                    dist *= 4;
                    if (dist > radius) {
                        return false;
                    }
                } else {
                    /#
                        debug_star(pos, (1, 0, 0), debug_display_time);
                    #/
                }
            }
        } else {
            /#
                debug_star(ent.entity.origin + (0, 0, assumed_ceiling_height), (1, 0, 0), debug_display_time);
            #/
        }
    }
    ent.damage = int(max + (min - max) * dist / radius);
    ent.pos = pos;
    ent.damageowner = owner;
    ent.einflictor = einflictor;
    return true;
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x963dfd68, Offset: 0x2c98
// Size: 0x70
function getmapcenter() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
    }
    return (0, 0, 0);
}

// Namespace airsupport/airsupport
// Params 4, eflags: 0x0
// Checksum 0xcb583de8, Offset: 0x2d10
// Size: 0x1f4
function getrandommappoint(x_offset, y_offset, map_x_percentage, map_y_percentage) {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        rand_x = 0;
        rand_y = 0;
        if (minimaporigins[0].origin[0] < minimaporigins[1].origin[0]) {
            rand_x = randomfloatrange(minimaporigins[0].origin[0] * map_x_percentage, minimaporigins[1].origin[0] * map_x_percentage);
            rand_y = randomfloatrange(minimaporigins[0].origin[1] * map_y_percentage, minimaporigins[1].origin[1] * map_y_percentage);
        } else {
            rand_x = randomfloatrange(minimaporigins[1].origin[0] * map_x_percentage, minimaporigins[0].origin[0] * map_x_percentage);
            rand_y = randomfloatrange(minimaporigins[1].origin[1] * map_y_percentage, minimaporigins[0].origin[1] * map_y_percentage);
        }
        return (x_offset + rand_x, y_offset + rand_y, 0);
    }
    return (x_offset, y_offset, 0);
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x5e42beb1, Offset: 0x2f10
// Size: 0xde
function getmaxmapwidth() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
        y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
        return max(x, y);
    }
    return 0;
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x22f48f5, Offset: 0x2ff8
// Size: 0x19c
function initrotatingrig() {
    if (isdefined(level.var_13d69428)) {
        level.airsupport_rotator = spawn("script_model", (isdefined(level.var_13d69428) ? level.var_13d69428 : 0, isdefined(level.var_40272f53) ? level.var_40272f53 : 0, isdefined(level.var_80b8dd62) ? level.var_80b8dd62 : 1200));
    } else {
        level.airsupport_rotator = spawn("script_model", getmapcenter() + (isdefined(level.rotator_x_offset) ? level.rotator_x_offset : 0, isdefined(level.rotator_y_offset) ? level.rotator_y_offset : 0, 1200));
    }
    level.airsupport_rotator setmodel(#"tag_origin");
    level.airsupport_rotator.angles = (0, 115, 0);
    level.airsupport_rotator hide();
    level.airsupport_rotator thread rotaterig();
    level.airsupport_rotator thread swayrig();
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xbba150af, Offset: 0x31a0
// Size: 0x2e
function rotaterig() {
    for (;;) {
        self rotateyaw(-360, 60);
        wait 60;
    }
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xfdca5897, Offset: 0x31d8
// Size: 0x10e
function swayrig() {
    centerorigin = self.origin;
    for (;;) {
        z = randomintrange(-200, -100);
        time = randomintrange(3, 6);
        self moveto(centerorigin + (0, 0, z), time, 1, 1);
        wait time;
        z = randomintrange(100, 200);
        time = randomintrange(3, 6);
        self moveto(centerorigin + (0, 0, z), time, 1, 1);
        wait time;
    }
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0x11b74160, Offset: 0x32f0
// Size: 0x3c
function stoprotation(time) {
    self endon(#"death");
    wait time;
    self stoploopsound();
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0xd62335e, Offset: 0x3338
// Size: 0xb8
function flattenyaw(goal) {
    self endon(#"death");
    increment = 3;
    if (self.angles[1] > goal) {
        increment *= -1;
    }
    while (abs(self.angles[1] - goal) > 3) {
        self.angles = (self.angles[0], self.angles[1] + increment, self.angles[2]);
        waitframe(1);
    }
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xafd45a80, Offset: 0x33f8
// Size: 0x6c
function flattenroll() {
    self endon(#"death");
    while (self.angles[2] < 0) {
        self.angles = (self.angles[0], self.angles[1], self.angles[2] + 2.5);
        waitframe(1);
    }
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0xf80a2b15, Offset: 0x3470
// Size: 0x28e
function leave(duration) {
    self unlink();
    self thread stoprotation(1);
    tries = 10;
    yaw = 0;
    while (tries > 0) {
        exitvector = anglestoforward(self.angles + (0, yaw, 0)) * 20000;
        exitpoint = (self.origin[0] + exitvector[0], self.origin[1] + exitvector[1], self.origin[2] - 2500);
        exitpoint = self.origin + exitvector;
        nfz = crossesnoflyzone(self.origin, exitpoint);
        if (isdefined(nfz)) {
            if (tries != 1) {
                if (tries % 2 == 1) {
                    yaw *= -1;
                } else {
                    yaw += 10;
                    yaw *= -1;
                }
            }
            tries--;
            continue;
        }
        tries = 0;
    }
    self thread flattenyaw(self.angles[1] + yaw);
    if (self.angles[2] != 0) {
        self thread flattenroll();
    }
    if (isvehicle(self)) {
        self setspeed(length(exitvector) / duration / 17.6, 60);
        self setgoal(exitpoint, 0, 0);
    } else {
        self moveto(exitpoint, duration, 0, 0);
    }
    self notify(#"leaving");
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xaa8a36af, Offset: 0x3708
// Size: 0x1d8
function getrandomhelicopterstartorigin() {
    dist = -1 * getdvarint(#"scr_supplydropincomingdistance", 10000);
    pathrandomness = 100;
    direction = (0, randomintrange(-2, 3), 0);
    start_origin = anglestoforward(direction) * dist;
    start_origin += ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);
    /#
        if (getdvarint(#"scr_noflyzones_debug", 0)) {
            if (level.noflyzones.size) {
                index = randomintrange(0, level.noflyzones.size);
                delta = level.noflyzones[index].origin;
                delta = (delta[0] + randomint(10), delta[1] + randomint(10), 0);
                delta = vectornormalize(delta);
                start_origin = delta * dist;
            }
        }
    #/
    return start_origin;
}

/#

    // Namespace airsupport/airsupport
    // Params 0, eflags: 0x0
    // Checksum 0xd96dc68b, Offset: 0x38e8
    // Size: 0x8e
    function debug_no_fly_zones() {
        for (i = 0; i < level.noflyzones.size; i++) {
            debug_airsupport_cylinder(level.noflyzones[i].origin, level.noflyzones[i].radius, level.noflyzones[i].height, (1, 1, 1), undefined, 5000);
        }
    }

    // Namespace airsupport/airsupport
    // Params 4, eflags: 0x0
    // Checksum 0x7c7114d1, Offset: 0x3980
    // Size: 0xc6
    function debug_plane_line(flytime, flyspeed, pathstart, pathend) {
        /#
            thread debug_line(pathstart, pathend, (1, 1, 1));
        #/
        delta = vectornormalize(pathend - pathstart);
        /#
            for (i = 0; i < flytime; i++) {
                thread debug_star(pathstart + vectorscale(delta, i * flyspeed), (1, 0, 0));
            }
        #/
    }

    // Namespace airsupport/airsupport
    // Params 1, eflags: 0x0
    // Checksum 0x4d307e5c, Offset: 0x3a50
    // Size: 0xac
    function debug_draw_bomb_explosion(prevpos) {
        self notify(#"draw_explosion");
        waitframe(1);
        self endon(#"draw_explosion");
        waitresult = self waittill(#"projectile_impact");
        /#
            thread debug_line(prevpos, waitresult.position, (0.5, 1, 0));
            thread debug_star(waitresult.position, (1, 0, 0));
        #/
    }

    // Namespace airsupport/airsupport
    // Params 3, eflags: 0x0
    // Checksum 0x491af92d, Offset: 0x3b08
    // Size: 0x128
    function debug_draw_bomb_path(projectile, color, time) {
        self endon(#"death");
        level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);
        if (!isdefined(color)) {
            color = (0.5, 1, 0);
        }
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            prevpos = self.origin;
            while (isdefined(self.origin)) {
                /#
                    thread debug_line(prevpos, self.origin, color, time);
                #/
                prevpos = self.origin;
                if (isdefined(projectile) && projectile) {
                    thread debug_draw_bomb_explosion(prevpos);
                }
                wait 0.2;
            }
        }
    }

    // Namespace airsupport/airsupport
    // Params 4, eflags: 0x0
    // Checksum 0x97b2adff, Offset: 0x3c38
    // Size: 0xe4
    function debug_print3d_simple(message, ent, offset, frames) {
        level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (isdefined(frames)) {
                thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, frames);
                return;
            }
            thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, 0);
        }
    }

    // Namespace airsupport/airsupport
    // Params 5, eflags: 0x0
    // Checksum 0xd122ca0, Offset: 0x3d28
    // Size: 0x10c
    function draw_text(msg, color, ent, offset, frames) {
        if (frames == 0) {
            while (isdefined(ent) && isdefined(ent.origin)) {
                print3d(ent.origin + offset, msg, color, 0.5, 4);
                waitframe(1);
            }
            return;
        }
        for (i = 0; i < frames; i++) {
            if (!isdefined(ent)) {
                break;
            }
            print3d(ent.origin + offset, msg, color, 0.5, 4);
            waitframe(1);
        }
    }

    // Namespace airsupport/airsupport
    // Params 5, eflags: 0x0
    // Checksum 0x5c272a7a, Offset: 0x3e40
    // Size: 0xac
    function debug_print3d(message, color, ent, origin_offset, frames) {
        level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            self thread draw_text(message, color, ent, origin_offset, frames);
        }
    }

    // Namespace airsupport/airsupport
    // Params 5, eflags: 0x0
    // Checksum 0xc0ef1c55, Offset: 0x3ef8
    // Size: 0xf4
    function debug_line(from, to, color, time, depthtest) {
        level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (distancesquared(from, to) < 0.01) {
                return;
            }
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(depthtest)) {
                depthtest = 1;
            }
            line(from, to, color, 1, depthtest, time);
        }
    }

    // Namespace airsupport/airsupport
    // Params 3, eflags: 0x0
    // Checksum 0xd579d4f4, Offset: 0x3ff8
    // Size: 0xb4
    function debug_star(origin, color, time) {
        level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            debugstar(origin, time, color);
        }
    }

    // Namespace airsupport/airsupport
    // Params 4, eflags: 0x0
    // Checksum 0xa31214f2, Offset: 0x40b8
    // Size: 0xc4
    function debug_circle(origin, radius, color, time) {
        level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            circle(origin, radius, color, 1, 1, time);
        }
    }

    // Namespace airsupport/airsupport
    // Params 5, eflags: 0x0
    // Checksum 0x8e0c1211, Offset: 0x4188
    // Size: 0x10c
    function debug_sphere(origin, radius, color, alpha, time) {
        level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            sides = int(10 * (1 + int(radius / 100)));
            sphere(origin, radius, color, alpha, 1, sides, time);
        }
    }

    // Namespace airsupport/airsupport
    // Params 6, eflags: 0x0
    // Checksum 0x889c53c4, Offset: 0x42a0
    // Size: 0xb4
    function debug_airsupport_cylinder(origin, radius, height, color, mustrenderheight, time) {
        level.airsupport_debug = getdvarint(#"scr_airsupport_debug", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            debug_cylinder(origin, radius, height, color, mustrenderheight, time);
        }
    }

    // Namespace airsupport/airsupport
    // Params 6, eflags: 0x0
    // Checksum 0x3498da41, Offset: 0x4360
    // Size: 0x134
    function debug_cylinder(origin, radius, height, color, mustrenderheight, time) {
        subdivision = 600;
        if (!isdefined(time)) {
            time = 1000;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        count = height / subdivision;
        for (i = 0; i < count; i++) {
            point = origin + (0, 0, i * subdivision);
            circle(point, radius, color, 1, 1, time);
        }
        if (isdefined(mustrenderheight)) {
            point = origin + (0, 0, mustrenderheight);
            circle(point, radius, color, 1, 1, time);
        }
    }

#/

// Namespace airsupport/airsupport
// Params 3, eflags: 0x0
// Checksum 0x265af09d, Offset: 0x44a0
// Size: 0xa0
function getpointonline(startpoint, endpoint, ratio) {
    nextpoint = (startpoint[0] + (endpoint[0] - startpoint[0]) * ratio, startpoint[1] + (endpoint[1] - startpoint[1]) * ratio, startpoint[2] + (endpoint[2] - startpoint[2]) * ratio);
    return nextpoint;
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0xac2bc114, Offset: 0x4548
// Size: 0x8a
function cantargetplayerwithspecialty() {
    if (self hasperk(#"specialty_nottargetedbyairsupport") || isdefined(self.specialty_nottargetedbyairsupport) && self.specialty_nottargetedbyairsupport) {
        if (!isdefined(self.nottargettedai_underminspeedtimer) || self.nottargettedai_underminspeedtimer < getdvarint(#"perk_nottargetedbyai_graceperiod", 0)) {
            return false;
        }
    }
    return true;
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0x42993599, Offset: 0x45e0
// Size: 0x1d4
function monitorspeed(spawnprotectiontime) {
    self endon(#"death");
    self endon(#"disconnect");
    if (self hasperk(#"specialty_nottargetedbyairsupport") == 0) {
        return;
    }
    getdvarstring(#"perk_nottargetted_graceperiod");
    graceperiod = getdvarint(#"perk_nottargetedbyai_graceperiod", 0);
    minspeed = getdvarint(#"perk_nottargetedbyai_min_speed", 0);
    minspeedsq = minspeed * minspeed;
    waitperiod = 0.25;
    waitperiodmilliseconds = int(waitperiod * 1000);
    if (minspeedsq == 0) {
        return;
    }
    self.nottargettedai_underminspeedtimer = 0;
    if (isdefined(spawnprotectiontime)) {
        wait spawnprotectiontime;
    }
    while (true) {
        velocity = self getvelocity();
        speedsq = lengthsquared(velocity);
        if (speedsq < minspeedsq) {
            self.nottargettedai_underminspeedtimer += waitperiodmilliseconds;
        } else {
            self.nottargettedai_underminspeedtimer = 0;
        }
        wait waitperiod;
    }
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x8f10be28, Offset: 0x47c0
// Size: 0x1a
function clearmonitoredspeed() {
    if (isdefined(self.nottargettedai_underminspeedtimer)) {
        self.nottargettedai_underminspeedtimer = 0;
    }
}

// Namespace airsupport/airsupport
// Params 1, eflags: 0x0
// Checksum 0xddb90fca, Offset: 0x47e8
// Size: 0x94
function function_277a9e(var_6d42ca94) {
    self clientfield::set_player_uimodel("locSel.snapTo", 0);
    self [[ var_6d42ca94 ]]();
    self.selectinglocation = 1;
    self thread endselectionthink();
    self clientfield::set_player_uimodel("locSel.commandMode", 0);
    self thread function_b08c23b5();
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x68adcb05, Offset: 0x4888
// Size: 0x92
function waitforlocationselection() {
    self endon(#"emp_jammed");
    self endon(#"emp_grenaded");
    waitresult = self waittill(#"confirm_location");
    locationinfo = spawnstruct();
    locationinfo.origin = waitresult.position;
    locationinfo.yaw = waitresult.yaw;
    return locationinfo;
}

// Namespace airsupport/airsupport
// Params 0, eflags: 0x0
// Checksum 0x3e3ac881, Offset: 0x4928
// Size: 0x2aa
function function_b08c23b5() {
    self endon(#"emp_jammed");
    self endon(#"emp_grenaded");
    self endon(#"disconnect");
    self endon(#"confirm_location");
    self endon(#"cancel_location");
    self endon(#"enter_vehicle");
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        if (menu == "LocationSelector") {
            if (response == "cancel") {
                self notify(#"cancel_location");
                return;
            }
            if (response == "player_location") {
                self notify(#"confirm_location", {#position:self.origin, #yaw:0});
                return;
            }
            if (response == "take_control") {
                self notify(#"enter_vehicle");
                return;
            }
            objid = waitresult.intpayload;
            foreach (point in level.var_474a12f2) {
                if (point.objectiveid == objid) {
                    self notify(#"confirm_location", {#position:point.origin, #yaw:point.yaw});
                    return;
                }
            }
            objpos = function_68693eb1(objid);
            if (isdefined(objpos)) {
                self notify(#"confirm_location", {#position:objpos, #yaw:0});
                return;
            }
        }
        waitframe(1);
    }
}

