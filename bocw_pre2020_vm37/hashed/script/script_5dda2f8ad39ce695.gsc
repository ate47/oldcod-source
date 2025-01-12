#using script_152c3f4ffef9e588;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_84ec8f9b;

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 0, eflags: 0x6
// Checksum 0x3a405a5e, Offset: 0x100
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_33e10510941e7e77", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 0, eflags: 0x4
// Checksum 0x68108079, Offset: 0x148
// Size: 0x94
function private function_70a657d8() {
    clientfield::register("scriptmover", "radiation_zone_intensity", 1, 3, "int");
    clientfield::register("toplayer", "radiation_zone_intensity", 1, 3, "int");
    callback::add_callback(#"hash_de3a4366fb5979e", &function_15068d03);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 0, eflags: 0x0
// Checksum 0xe257ee09, Offset: 0x1e8
// Size: 0x4bc
function start() {
    /#
        if (getdvarint(#"hash_2287be0e852cba9f", 0)) {
            return;
        }
    #/
    bounds = undefined;
    if (isstruct(level.territory) && isarray(level.territory.bounds) && level.territory.bounds.size > 0) {
        absmins = [];
        absmaxs = [];
        foreach (bound in level.territory.bounds) {
            var_f3ba0cb3 = bound.origin + bound.mins;
            var_cd8bd6d = bound.origin + bound.maxs;
            for (i = 0; i < 2; i++) {
                if (!isdefined(absmins[i])) {
                    absmins[i] = var_f3ba0cb3[i];
                }
                if (!isdefined(absmaxs[i])) {
                    absmaxs[i] = var_cd8bd6d[i];
                }
                absmins[i] = min(absmins[i], var_f3ba0cb3[i]);
                absmaxs[i] = max(absmaxs[i], var_cd8bd6d[i]);
            }
        }
        buffer = (5200, 5200, 0);
        bounds = {#absmins:(absmins[0], absmins[1], 0), #absmaxs:(absmaxs[0], absmaxs[1], 0), #buffer:buffer};
    } else {
        bounds = {#absmins:(-5000, -5000, 0), #absmaxs:(5000, 5000, 0), #buffer:(500, 500, 0)};
    }
    var_b16c122 = function_d764a450();
    finalradius = function_fb6494ee(bounds, var_b16c122);
    var_9b9b6a = getdvarint(#"hash_59f694f296f44c85", 600);
    var_9bbce2cd = {#bounds:bounds, #var_b16c122:var_b16c122, #var_91017512:finalradius / 5, #var_8a0314b0:5, #var_e48e9559:3, #var_3d01e8e0:var_9b9b6a, #var_5f2bbf7d:0.5, #burst:0, #stages:[]};
    level.var_9bbce2cd = var_9bbce2cd;
    level thread function_9f1ed45c(var_9bbce2cd);
    level thread function_1ea2ba18(var_9bbce2cd);
    level thread function_8682f26a(var_9bbce2cd);
    level thread function_32d815a6(var_9bbce2cd);
    callback::callback(#"hash_6adbe5700aba9035", var_9bbce2cd);
    /#
        level thread function_35e704db(var_9bbce2cd);
    #/
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x9623a972, Offset: 0x6b0
// Size: 0x146
function private function_8682f26a(var_9bbce2cd) {
    level endon(#"game_ended", #"hash_771e291aabbbf971");
    var_8a0314b0 = var_9bbce2cd.var_8a0314b0;
    radius = 0;
    origin = var_9bbce2cd.var_b16c122;
    stages = var_9bbce2cd.stages;
    var_ba542003 = var_9bbce2cd.var_3d01e8e0 / var_8a0314b0;
    var_91017512 = var_9bbce2cd.var_91017512;
    while (stages.size < var_8a0314b0) {
        function_fcff2bd0(var_9bbce2cd);
        stage = function_4ff03eb8(origin, radius, 1);
        stages[stages.size] = stage;
        radius += var_91017512;
        function_a04790f1(stage, radius, var_ba542003);
    }
    do {
        wait var_ba542003;
    } while (function_fcff2bd0(var_9bbce2cd));
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0xf57c43da, Offset: 0x800
// Size: 0x44
function private function_15068d03(dirtybomb) {
    if (isstruct(dirtybomb.var_9bbce2cd)) {
        level thread function_180088a8(dirtybomb.var_9bbce2cd);
    }
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x319c3c9c, Offset: 0x850
// Size: 0x2e6
function private function_180088a8(var_9bbce2cd) {
    level notify(#"hash_771e291aabbbf971");
    var_9bbce2cd.burst = 1;
    var_8a0314b0 = var_9bbce2cd.var_8a0314b0;
    radius = 0;
    origin = var_9bbce2cd.var_b16c122;
    stages = var_9bbce2cd.stages;
    var_ba542003 = var_9bbce2cd.var_3d01e8e0 / var_8a0314b0;
    var_91017512 = var_9bbce2cd.var_91017512;
    var_c572ea4c = undefined;
    foreach (i, stage in stages) {
        var_c572ea4c = stage;
        radius += var_91017512;
        intensity = int(max(5 - i, 1));
        function_b8aca128(stage, intensity);
    }
    function_8f75d807(var_9bbce2cd);
    if (isdefined(var_c572ea4c)) {
        var_66290dd3 = radius - var_c572ea4c.radius;
        if (var_66290dd3 > 0) {
            scalesec = stages.size < 1 ? var_9bbce2cd.var_5f2bbf7d : var_ba542003;
            var_dda41022 = var_66290dd3 / var_91017512;
            function_a04790f1(var_c572ea4c, radius, var_dda41022 * scalesec);
        }
    }
    while (stages.size < var_8a0314b0) {
        intensity = int(max(5 - stages.size, 1));
        stage = function_4ff03eb8(origin, radius, intensity);
        stages[stages.size] = stage;
        radius += var_91017512;
        function_a04790f1(stage, radius, var_ba542003);
    }
    var_ba542003 = var_9bbce2cd.var_3d01e8e0 / var_8a0314b0 / 2;
    do {
        wait var_ba542003;
    } while (function_fcff2bd0(stages));
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x400bb64f, Offset: 0xb40
// Size: 0xe0
function private function_fcff2bd0(var_9bbce2cd) {
    var_6b3c79ac = 0;
    foreach (stage in var_9bbce2cd.stages) {
        if (stage.intensity < 5) {
            var_6b3c79ac = 1;
            function_b8aca128(stage, stage.intensity + 1);
        }
    }
    function_8f75d807(var_9bbce2cd);
    return var_6b3c79ac;
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x2dcab9e7, Offset: 0xc28
// Size: 0x1c4
function private function_32d815a6(var_9bbce2cd) {
    level endon(#"game_ended");
    stages = var_9bbce2cd.stages;
    while (true) {
        var_aa189ccb = var_9bbce2cd.var_aa189ccb;
        foreach (player in getplayers()) {
            if (!isalive(player)) {
                player clientfield::set_to_player("radiation_zone_intensity", 0);
                continue;
            }
            if (isdefined(var_aa189ccb) && var_aa189ccb.radiussq > 0) {
                distsq = distance2dsquared(player.origin, var_aa189ccb.origin);
                if (distsq <= var_aa189ccb.radiussq) {
                    player clientfield::set_to_player("radiation_zone_intensity", 0);
                    continue;
                }
            }
            if (!function_931926e6(player, stages)) {
                player clientfield::set_to_player("radiation_zone_intensity", 0);
            }
        }
        wait 1.5;
    }
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 2, eflags: 0x4
// Checksum 0xe3e94fb9, Offset: 0xdf8
// Size: 0x16e
function private function_931926e6(player, stages) {
    foreach (stage in stages) {
        if (stage.radiussq > 0 && stage.intensity >= 1 && stage.intensity <= 5) {
            distsq = distance2dsquared(player.origin, stage.origin);
            if (distsq <= stage.radiussq) {
                radiation = stage.intensity;
                radiation::function_2f76803d(player, radiation);
                player clientfield::set_to_player("radiation_zone_intensity", stage.intensity);
                return true;
            }
        }
    }
    radiation::function_2f76803d(player, 0);
    return false;
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x1a36544, Offset: 0xf70
// Size: 0x3a
function private function_9f1ed45c(var_9bbce2cd) {
    level endon(#"game_ended");
    var_9bbce2cd.var_f489058e = function_b1375495(var_9bbce2cd);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0xfd36bbf2, Offset: 0xfb8
// Size: 0x1ea
function private function_b1375495(var_9bbce2cd) {
    level endon(#"game_ended");
    absmins = var_9bbce2cd.bounds.absmins + var_9bbce2cd.bounds.buffer;
    absmaxs = var_9bbce2cd.bounds.absmaxs - var_9bbce2cd.bounds.buffer;
    var_b16c122 = var_9bbce2cd.var_b16c122;
    var_91017512 = var_9bbce2cd.var_91017512;
    minradius = var_91017512 * var_9bbce2cd.var_e48e9559;
    maxradius = minradius + var_91017512;
    minradius += 4000;
    maxradius = max(minradius, maxradius);
    while (true) {
        angle = randomint(360);
        radius = randomfloatrange(minradius, maxradius);
        origin = var_b16c122 + radius * (cos(angle), sin(angle), 0);
        if (origin[0] > absmins[0] && origin[0] < absmaxs[0] && origin[1] > absmins[1] && origin[1] < absmaxs[1]) {
            return origin;
        }
        waitframe(1);
    }
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0xde8215f4, Offset: 0x11b0
// Size: 0x82
function private function_1ea2ba18(var_9bbce2cd) {
    level endon(#"game_ended");
    if (isdefined(var_9bbce2cd.var_aa189ccb)) {
        return;
    }
    while (!isdefined(var_9bbce2cd.var_f489058e)) {
        waitframe(1);
    }
    origin = var_9bbce2cd.var_f489058e;
    var_9bbce2cd.var_aa189ccb = function_4ff03eb8(origin, 4000, 7);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 3, eflags: 0x4
// Checksum 0xf01d76f2, Offset: 0x1240
// Size: 0xa0
function private function_4ff03eb8(origin, radius, intensity) {
    stage = spawn("script_model", origin);
    stage.team = #"neutral";
    stage setmodel("tag_origin");
    function_c87d1e9a(stage, radius);
    function_b8aca128(stage, intensity);
    return stage;
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 2, eflags: 0x4
// Checksum 0xa02ac149, Offset: 0x12e8
// Size: 0xa2
function private function_c87d1e9a(stage, radius) {
    if (radius > 0) {
        stage show();
        stage.radius = radius;
        stage.radiussq = radius * radius;
        stage setscale(radius / 15000);
        return;
    }
    stage hide();
    stage.radius = 0;
    stage.radiussq = 0;
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 2, eflags: 0x4
// Checksum 0x7e4d3e6a, Offset: 0x1398
// Size: 0x44
function private function_b8aca128(stage, intensity) {
    stage.intensity = intensity;
    stage clientfield::set("radiation_zone_intensity", intensity);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x45c81060, Offset: 0x13e8
// Size: 0xf0
function private function_8f75d807(var_9bbce2cd) {
    if (is_true(var_9bbce2cd.var_2955560f)) {
        return;
    }
    foreach (stage in var_9bbce2cd.stages) {
        if (stage.intensity != 7 && stage.intensity >= 5) {
            var_9bbce2cd.var_2955560f = 1;
            callback::callback(#"hash_1002f619f2d58b36", var_9bbce2cd);
        }
    }
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 3, eflags: 0x4
// Checksum 0xac543b1f, Offset: 0x14e0
// Size: 0x15c
function private function_a04790f1(stage, newradius, scalesec) {
    level endon(#"game_ended", #"hash_771e291aabbbf971");
    time = gettime();
    endtime = time + int(scalesec * 1000);
    var_76c954d6 = newradius - stage.radius;
    frames = scalesec / float(function_60d95f53()) / 1000;
    framedelta = var_76c954d6 / frames;
    while (time < endtime) {
        function_c87d1e9a(stage, stage.radius + framedelta);
        if (stage.radius <= 0) {
            return;
        }
        waitframe(1);
        time = gettime();
    }
    function_c87d1e9a(stage, newradius);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x588c2883, Offset: 0x1648
// Size: 0xfc
function private function_707332e7(bounds) {
    attempts = 0;
    while (attempts < 20) {
        attempts++;
        origin = function_3ae922d3(bounds);
        trace = ground_trace(origin);
        if (!function_fc2d62a9(trace)) {
            continue;
        }
        return origin;
    }
    x = (bounds.absmins[0] + bounds.absmaxs[0]) / 2;
    y = (bounds.absmins[1] + bounds.absmaxs[1]) / 2;
    return (x, y, 0);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 0, eflags: 0x4
// Checksum 0x7d813070, Offset: 0x1750
// Size: 0xa6
function private function_d764a450() {
    points = function_4ee7d15();
    origin = points[randomint(points.size)];
    trace = groundtrace(origin + (0, 0, 50), origin + (0, 0, -100), 0, undefined);
    return trace[#"position"];
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 0, eflags: 0x4
// Checksum 0x773b529a, Offset: 0x1800
// Size: 0x5a
function private function_4ee7d15() {
    return array((-53839, -2785, -441), (-15804, 1603, -931), (-47610, 39976, 923), (-14948, 42452, -2954), (-40598, 30540, 912));
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 0, eflags: 0x4
// Checksum 0xc6743287, Offset: 0x1868
// Size: 0xd6
function private function_6e6dd353() {
    structs = struct::get_array(#"hash_40fb3326901bb84b", "targetname");
    if (structs.size <= 0) {
        return undefined;
    }
    struct = structs[randomint(structs.size)];
    trace = groundtrace(struct.origin + (0, 0, 50), struct.origin + (0, 0, -100), 0, undefined);
    return trace[#"position"];
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x3afec9f7, Offset: 0x1948
// Size: 0xb6
function private function_3ae922d3(bounds) {
    buffer = bounds.buffer;
    absmins = bounds.absmins + buffer;
    absmaxs = bounds.absmaxs - buffer;
    x = randomfloatrange(absmins[0], absmaxs[0]);
    y = randomfloatrange(absmins[1], absmaxs[1]);
    return (x, y, 0);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0xb20dbe39, Offset: 0x1a08
// Size: 0x52
function private ground_trace(origin) {
    return groundtrace(origin + (0, 0, 20000), origin + (0, 0, -10000), 0, undefined);
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 1, eflags: 0x4
// Checksum 0x5ea6377f, Offset: 0x1a68
// Size: 0x6e
function private function_fc2d62a9(trace) {
    return trace[#"fraction"] < 1 && trace[#"surfacetype"] != #"water" && trace[#"surfacetype"] != #"watershallow";
}

// Namespace namespace_84ec8f9b/namespace_84ec8f9b
// Params 2, eflags: 0x4
// Checksum 0x3fe6f5c5, Offset: 0x1ae0
// Size: 0x174
function private function_fb6494ee(bounds, origin) {
    maxdist = distance2d(origin, bounds.absmaxs);
    dists = [];
    dists[1] = distance2d(origin, bounds.absmins);
    dists[2] = distance2d(origin, (bounds.absmins[0], bounds.absmaxs[1], 0));
    dists[3] = distance2d(origin, (bounds.absmaxs[0], bounds.absmins[1], 0));
    foreach (dist in dists) {
        if (dist > maxdist) {
            maxdist = dist;
        }
    }
    return maxdist;
}

/#

    // Namespace namespace_84ec8f9b/namespace_84ec8f9b
    // Params 1, eflags: 0x4
    // Checksum 0xbe6982b7, Offset: 0x1c60
    // Size: 0x53c
    function private function_35e704db(var_9bbce2cd) {
        level endon(#"game_ended");
        absmins = var_9bbce2cd.bounds.absmins + (0, 0, -10000);
        absmaxs = var_9bbce2cd.bounds.absmaxs + (0, 0, 20000);
        buffer = var_9bbce2cd.bounds.buffer;
        var_ea170696 = absmins + buffer;
        var_5ae94e57 = absmaxs - buffer;
        var_8a0314b0 = var_9bbce2cd.var_8a0314b0;
        var_91017512 = var_9bbce2cd.var_91017512;
        var_89a18cc6 = function_4ee7d15();
        while (true) {
            if (!getdvarint(#"hash_14465d5471ae88cf", 0)) {
                waitframe(1);
                continue;
            }
            box((0, 0, 0), absmins, absmaxs, 0, (1, 0, 1));
            box((0, 0, 0), var_ea170696, var_5ae94e57, 0, (0, 1, 1));
            foreach (point in var_89a18cc6) {
                line(point + (0, 0, -10000), point + (0, 0, 20000), (0, 1, 1));
            }
            if (isdefined(var_9bbce2cd.var_b16c122)) {
                line(var_9bbce2cd.var_b16c122 + (0, 0, -10000), var_9bbce2cd.var_b16c122 + (0, 0, 20000), (1, 0, 0));
                radius = var_91017512;
                for (i = 0; i < var_8a0314b0; i++) {
                    color = function_c833e7c3(i, var_8a0314b0 - 1);
                    circle(var_9bbce2cd.var_b16c122, radius, color, 0, 1);
                    radius += var_91017512;
                }
            }
            if (isdefined(var_9bbce2cd.var_f489058e)) {
                line(var_9bbce2cd.var_f489058e + (0, 0, -10000), var_9bbce2cd.var_f489058e + (0, 0, 20000), (0, 1, 0));
                circle(var_9bbce2cd.var_f489058e, 4000, (0, 1, 0), 0, 1);
            }
            if (isdefined(var_9bbce2cd.var_d155bf18)) {
                foreach (point in var_9bbce2cd.var_d155bf18) {
                    line(point + (0, 0, -10000), point + (0, 0, 20000), (1, 1, 0));
                }
            }
            var_b4e11627 = getdvarint(#"hash_3646ec0527014b7d", 0);
            if (var_b4e11627 > 0) {
                setdvar(#"hash_3646ec0527014b7d", 0);
                level notify(#"hash_1fd521f93ed40fb6");
                level thread function_eea4e3c8(var_9bbce2cd, var_b4e11627);
            }
            if (getdvarint(#"hash_52fca63eee42c041", 0)) {
                setdvar(#"hash_52fca63eee42c041", 0);
                level notify(#"hash_1fd521f93ed40fb6");
                level.var_9bbce2cd.var_d155bf18 = undefined;
            }
            waitframe(1);
        }
    }

    // Namespace namespace_84ec8f9b/namespace_84ec8f9b
    // Params 2, eflags: 0x4
    // Checksum 0x8f7c5bd2, Offset: 0x21a8
    // Size: 0x9c
    function private function_eea4e3c8(var_9bbce2cd, count) {
        level endon(#"game_ended", #"hash_1fd521f93ed40fb6");
        var_c5f541ca = [];
        var_9bbce2cd.var_d155bf18 = var_c5f541ca;
        while (var_c5f541ca.size < count) {
            testpoint = function_b1375495(var_9bbce2cd);
            var_c5f541ca[var_c5f541ca.size] = testpoint;
            waitframe(1);
        }
    }

    // Namespace namespace_84ec8f9b/namespace_84ec8f9b
    // Params 2, eflags: 0x0
    // Checksum 0xd95a0cf, Offset: 0x2250
    // Size: 0x104
    function function_c833e7c3(index, maxindex) {
        colorscale = array((1, 0, 0), (1, 0.5, 0), (1, 1, 0), (0, 1, 0));
        if (index >= maxindex) {
            return colorscale[colorscale.size - 1];
        } else if (index <= 0) {
            return colorscale[0];
        }
        var_30de3274 = index * colorscale.size / maxindex;
        var_30de3274 -= 1;
        colorindex = int(var_30de3274);
        colorfrac = var_30de3274 - colorindex;
        return vectorlerp(colorscale[colorindex], colorscale[colorindex + 1], colorfrac);
    }

#/
