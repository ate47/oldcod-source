#using script_396f7d71538c9677;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#using scripts\weapons\weapons;

#namespace namespace_68a80213;

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x6
// Checksum 0xbef978cf, Offset: 0x218
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_512409f8a5de10e4", &init_shared, undefined, undefined, undefined);
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x0
// Checksum 0xe0603ae5, Offset: 0x260
// Size: 0xcc
function init_shared() {
    clientfield::register("actor", "" + #"hash_c5d06ae18fde4c0", 1, 1, "int");
    params = getstatuseffect("dot_molotov_dog");
    level.var_e6a4f161 = params.var_18d16a6b;
    level.var_5d450296 = params.setype;
    level.var_e8a6b3ee = [];
    spawner::add_archetype_spawn_function(#"zombie_dog", &function_4f3cd1f0);
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x0
// Checksum 0x5fc9c7c6, Offset: 0x338
// Size: 0x5c
function function_4f3cd1f0() {
    if (self.var_9fde8624 === #"hash_28e36e7b7d5421f") {
        self.var_90d0c0ff = "anim_spawn_hellhound";
        self callback::function_d8abfc3d(#"on_dog_killed", &function_84a3128e);
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x0
// Checksum 0x86dca272, Offset: 0x3a0
// Size: 0x1dc
function function_84a3128e() {
    if (!isdefined(self.exploded) && !is_true(self.var_270befd2)) {
        self.exploded = 1;
        self clientfield::set("" + #"hash_c5d06ae18fde4c0", 1);
        var_3e7a440 = getscriptbundle("molotov_custom_settings");
        blast_radius = 97;
        var_83f35abe = 25;
        var_6927cfa0 = 10;
        radiusdamage(self.origin + (0, 0, 18), blast_radius, var_83f35abe, var_6927cfa0, undefined, "MOD_EXPLOSIVE");
        function_ccb2e201(self.origin + (0, 0, 18), blast_radius);
        if (!isdefined(self.var_338d4a29) || self.var_338d4a29 == 0) {
            function_e8ad1d81(self.origin, (0, 0, 1), (0, 0, 1), self.team, var_3e7a440);
        }
        self.var_7a68cd0c = 1;
        self ghost();
        self notsolid();
        if (isalive(self)) {
            self kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 1, eflags: 0x0
// Checksum 0x5d00c5bd, Offset: 0x588
// Size: 0x42
function is_under_water(position) {
    water_depth = getwaterheight(position) - position[2];
    return water_depth >= 24;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 1, eflags: 0x0
// Checksum 0x13d0157a, Offset: 0x5d8
// Size: 0x24
function function_a66ba8cc(water_depth) {
    return 0 < water_depth && water_depth < 24;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 1, eflags: 0x0
// Checksum 0x21321950, Offset: 0x608
// Size: 0x2c
function get_water_depth(position) {
    return getwaterheight(position) - position[2];
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 1, eflags: 0x0
// Checksum 0xdfb39461, Offset: 0x640
// Size: 0x84
function function_7cbeb2f0(normal) {
    if (normal[2] < 0.5) {
        stepoutdistance = normal * getdvarint(#"hash_72463d6fcf7cb178", 50);
    } else {
        stepoutdistance = normal * getdvarint(#"hash_1423ebf820f9483f", 12);
    }
    return stepoutdistance;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 5, eflags: 0x0
// Checksum 0xaaf71a3f, Offset: 0x6d0
// Size: 0x8bc
function function_e8ad1d81(position, normal, velocity, team, customsettings) {
    originalposition = position;
    var_493d36f9 = normal;
    var_77261b6 = vectornormalize(velocity);
    var_1f254a06 = vectorscale(var_77261b6, -1);
    var_d6d43109 = 1;
    var_e76400c0 = undefined;
    wallnormal = undefined;
    var_693f108f = undefined;
    var_aecaaa11 = getweapon(#"molotov_fire");
    var_5632b17 = getweapon("molotov_fire_wall");
    var_7bf146f2 = getweapon("molotov_steam");
    if (normal[2] < -0.5) {
        var_36c22d1d = position + vectorscale(normal, 2);
        var_8ae62b02 = var_36c22d1d - (0, 0, 240);
        var_69d15ad0 = physicstrace(var_36c22d1d, var_8ae62b02, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), self, 1);
        if (var_69d15ad0[#"fraction"] < 1) {
            position = var_69d15ad0[#"position"];
            if (var_69d15ad0[#"fraction"] > 0) {
                normal = var_69d15ad0[#"normal"];
            } else {
                normal = (0, 0, 1);
            }
            var_1b1117c6 = 1.2 * var_69d15ad0[#"fraction"];
            var_1f254a06 = normal;
            if (var_1b1117c6 > 0) {
                wait var_1b1117c6;
            }
        } else {
            return;
        }
    } else if (normal[2] < 0.5) {
        var_36c22d1d = position + vectorscale(var_493d36f9, 2);
        var_8ae62b02 = var_36c22d1d - (0, 0, 20);
        var_69d15ad0 = physicstrace(var_36c22d1d, var_8ae62b02, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), self, 1);
        if (var_69d15ad0[#"fraction"] < 1) {
            position = var_36c22d1d;
            if (var_69d15ad0[#"fraction"] > 0) {
                normal = var_69d15ad0[#"normal"];
            } else {
                normal = (0, 0, 1);
            }
        }
    }
    if (normal[2] < 0.5) {
        wall_normal = normal;
        var_36c22d1d = originalposition + vectorscale(var_493d36f9, 8);
        var_8ae62b02 = var_36c22d1d - (0, 0, 300);
        var_69d15ad0 = physicstrace(var_36c22d1d, var_8ae62b02, (-3, -3, -3), (3, 3, 3), self, 1);
        var_693f108f = var_69d15ad0[#"fraction"] * 300;
        var_959a2a8b = 0;
        if (var_693f108f > 10) {
            var_e76400c0 = originalposition;
            wallnormal = var_493d36f9;
            var_d6d43109 = sqrt(1 - var_69d15ad0[#"fraction"]);
            var_959a2a8b = 1;
        }
        if (var_69d15ad0[#"fraction"] < 1) {
            position = var_69d15ad0[#"position"];
            if (var_69d15ad0[#"fraction"] > 0) {
                normal = var_69d15ad0[#"normal"];
            } else {
                normal = (0, 0, 1);
            }
        }
        if (var_959a2a8b) {
            x = originalposition[0];
            y = originalposition[1];
            lowestz = var_69d15ad0[#"position"][2];
            for (z = originalposition[2]; z > lowestz; z -= randomintrange(20, 30)) {
                newpos = (x, y, z);
                water_depth = get_water_depth(newpos);
                if (function_a66ba8cc(water_depth) || is_under_water(newpos)) {
                    newpos -= (0, 0, water_depth);
                    level thread function_42b9fdbe(var_7bf146f2, newpos, (0, 0, 1), int(5), team);
                    break;
                }
                level thread function_42b9fdbe(var_5632b17, newpos, wall_normal, int(5), team);
            }
            var_bc9ec158 = 0.6 * var_69d15ad0[#"fraction"];
            if (var_bc9ec158 > 0) {
                wait var_bc9ec158;
            }
        }
    }
    startpos = position + function_7cbeb2f0(normal);
    desiredendpos = startpos + (0, 0, 60);
    function_1493c734(startpos, 20, (0, 1, 0), 0.6, 200);
    phystrace = physicstrace(startpos, desiredendpos, (-4, -4, -4), (4, 4, 4), self, 1);
    goalpos = phystrace[#"fraction"] > 1 ? desiredendpos : phystrace[#"position"];
    rotation = randomint(360);
    if (normal[2] < 0.1 && !isdefined(var_e76400c0)) {
        black = (0.1, 0.1, 0.1);
        trace = hitpos(startpos, startpos + normal * -1 * 70 + (0, 0, -1) * 70, black);
        traceposition = trace[#"position"];
        if (trace[#"fraction"] < 0.9) {
            var_252a0dc7 = trace[#"normal"];
            spawntimedfx(var_5632b17, traceposition, var_252a0dc7, int(5), team);
        }
    }
    var_1f254a06 = normal;
    level function_8a03d3f3(position, startpos, var_1f254a06, var_d6d43109, rotation, team, var_e76400c0, wallnormal, var_693f108f, customsettings);
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 7, eflags: 0x0
// Checksum 0xd146a25, Offset: 0xf98
// Size: 0x8c
function function_523961e2(startpos, normal, var_4997e17c, fxindex, fxcount, defaultdistance, rotation) {
    currentangle = 360 / fxcount * fxindex;
    var_7ee25402 = rotatepointaroundaxis(var_4997e17c * defaultdistance, normal, currentangle + rotation);
    return startpos + var_7ee25402;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x0
// Checksum 0x4ece4315, Offset: 0x1030
// Size: 0xe4
function function_31cc6bd9() {
    if (!isdefined(level.var_a88ac760)) {
        return;
    }
    keys = getarraykeys(level.var_a88ac760);
    time = gettime();
    foreach (key in keys) {
        if (level.var_a88ac760[key].var_46ee5246 < time) {
            level.var_a88ac760[key] = undefined;
        }
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 2, eflags: 0x0
// Checksum 0x46ff7ead, Offset: 0x1120
// Size: 0xfe
function function_31f342a2(origin, var_9c7e3678) {
    if (!isdefined(level.var_a88ac760)) {
        return false;
    }
    foreach (molotov in level.var_a88ac760) {
        if (abs(molotov.origin[2] - origin[2] > 20)) {
            continue;
        }
        if (distance2dsquared(molotov.origin, origin) < var_9c7e3678) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 10, eflags: 0x0
// Checksum 0xb1f526e0, Offset: 0x1228
// Size: 0xe58
function function_8a03d3f3(impactpos, startpos, normal, multiplier, rotation, team, var_e76400c0, wallnormal, var_693f108f, customsettings) {
    defaultdistance = 65 * multiplier;
    defaultdropdistance = getdvarint(#"hash_4a8fc6d7cacea9d5", 90);
    colorarray = [];
    colorarray[colorarray.size] = (0.9, 0.2, 0.2);
    colorarray[colorarray.size] = (0.2, 0.9, 0.2);
    colorarray[colorarray.size] = (0.2, 0.2, 0.9);
    colorarray[colorarray.size] = (0.9, 0.9, 0.9);
    locations = [];
    locations[#"color"] = [];
    locations[#"loc"] = [];
    locations[#"tracepos"] = [];
    locations[#"distsqrd"] = [];
    locations[#"fxtoplay"] = [];
    locations[#"radius"] = [];
    locations[#"tallfire"] = [];
    locations[#"smallfire"] = [];
    locations[#"steam"] = [];
    fxcount = 7;
    var_33ad9452 = isdefined(1) ? 1 : 0;
    fxcount = int(math::clamp(fxcount * multiplier + 6, 6, 7));
    if (multiplier < 0.04) {
        fxcount = 0;
    }
    function_31cc6bd9();
    if (function_31f342a2(startpos, function_a3f6cdac(97.5)) && fxcount > 10) {
        fxcount = 7;
    }
    var_4997e17c = perpendicularvector(normal);
    for (fxindex = 0; fxindex < fxcount; fxindex++) {
        locations[#"point"][fxindex] = function_523961e2(startpos, normal, var_4997e17c, fxindex, fxcount, defaultdistance, rotation);
        function_1493c734(locations[#"point"][fxindex], 10, (0, fxindex * 20, 0), 0.6, 200);
        locations[#"color"][fxindex] = colorarray[fxindex % colorarray.size];
    }
    var_1cac1ca8 = normal[2] > 0.5;
    for (count = 0; count < fxcount; count++) {
        trace = hitpos(startpos, locations[#"point"][count], locations[#"color"][count]);
        traceposition = trace[#"position"];
        locations[#"tracepos"][count] = traceposition;
        hitsomething = 0;
        if (trace[#"fraction"] < 0.7) {
            function_1493c734(traceposition, 10, (1, 0, 0), 0.6, 200);
            locations[#"loc"][count] = traceposition;
            locations[#"normal"][count] = trace[#"normal"];
            if (var_1cac1ca8) {
                locations[#"tallfire"][count] = 1;
            }
            hitsomething = 1;
        }
        if (!hitsomething) {
            var_e5d1793d = hitpos(traceposition, traceposition - normal * defaultdropdistance, locations[#"color"][count]);
            if (var_e5d1793d[#"fraction"] != 1) {
                function_1493c734(var_e5d1793d[#"position"], 10, (0, 0, 1), 0.6, 200);
                locations[#"loc"][count] = var_e5d1793d[#"position"];
                water_depth = get_water_depth(var_e5d1793d[#"position"]);
                if (function_a66ba8cc(water_depth)) {
                    locations[#"normal"][count] = (0, 0, 1);
                    locations[#"steam"][count] = 1;
                    locations[#"loc"][count] = locations[#"loc"][count] - (0, 0, water_depth);
                } else {
                    locations[#"normal"][count] = var_e5d1793d[#"normal"];
                    locations[#"smallfire"][count] = 1;
                }
            }
        }
        randangle = randomint(360);
        var_c4b09917 = randomfloatrange(-25, 25);
        var_7ee25402 = rotatepointaroundaxis(var_4997e17c, normal, randangle);
        var_995eb37a = int(min(var_33ad9452 * multiplier * trace[#"fraction"] + 1, var_33ad9452));
        for (var_ecef2fde = 0; var_ecef2fde < var_995eb37a && count % 2 == 0; var_ecef2fde++) {
            fraction = (var_ecef2fde + 1) / (var_995eb37a + 1);
            offsetpoint = startpos + (traceposition - startpos) * fraction + var_7ee25402 * var_c4b09917;
            var_9417df90 = hitpos(offsetpoint, offsetpoint - normal * defaultdropdistance, locations[#"color"][count]);
            if (var_9417df90[#"fraction"] != 1) {
                function_1493c734(var_9417df90[#"position"], 10, (0, 0, 1), 0.6, 200);
                locindex = count + fxcount * (var_ecef2fde + 1);
                locations[#"loc"][locindex] = var_9417df90[#"position"];
                water_depth = get_water_depth(var_9417df90[#"position"]);
                if (function_a66ba8cc(water_depth)) {
                    locations[#"normal"][locindex] = (0, 0, 1);
                    locations[#"steam"][locindex] = 1;
                    locations[#"loc"][locindex] = locations[#"loc"][locindex] - (0, 0, water_depth);
                    continue;
                }
                locations[#"normal"][locindex] = var_9417df90[#"normal"];
            }
        }
    }
    var_aecaaa11 = getweapon(#"molotov_fire");
    var_3cbce009 = getweapon("molotov_fire_tall");
    var_4a1b9411 = getweapon("molotov_fire_small");
    var_7bf146f2 = getweapon("molotov_steam");
    var_6b23e1c9 = impactpos + normal * 1.5;
    forward = (1, 0, 0);
    if (abs(vectordot(forward, normal)) > 0.999) {
        forward = (0, 0, 1);
    }
    if (!is_under_water(var_6b23e1c9)) {
        playfx(#"hash_789d7811f6a28f9a", var_6b23e1c9, forward, normal, 0, team);
        if (!isdefined(var_e76400c0)) {
            spawntimedfx(var_aecaaa11, var_6b23e1c9, normal, int(5), team);
        }
    }
    if (level.gameended) {
        return;
    }
    if (!isdefined(level.var_801fd65e)) {
        level.var_801fd65e = 0;
    }
    if (!isdefined(level.var_a88ac760)) {
        level.var_a88ac760 = [];
    }
    var_bf264593 = level.var_a88ac760.size;
    level.var_a88ac760[var_bf264593] = {};
    var_4b424bc1 = level.var_a88ac760[var_bf264593];
    var_4b424bc1.var_46ee5246 = int(gettime() + 5000);
    var_4b424bc1.origin = startpos;
    thread damageeffectarea(startpos, normal, var_aecaaa11, multiplier, var_e76400c0, wallnormal, var_693f108f, var_4b424bc1.var_46ee5246, customsettings);
    thread function_9464e4ad(startpos, normal, var_aecaaa11, multiplier, var_e76400c0, wallnormal, var_693f108f, var_4b424bc1.var_46ee5246, customsettings);
    var_b1dd2ca0 = getarraykeys(locations[#"loc"]);
    foreach (lockey in var_b1dd2ca0) {
        if (!isdefined(lockey)) {
            continue;
        }
        if (is_under_water(locations[#"loc"][lockey])) {
            continue;
        }
        if (isdefined(locations[#"smallfire"][lockey])) {
            fireweapon = var_4a1b9411;
        } else if (isdefined(locations[#"steam"][lockey])) {
            fireweapon = var_7bf146f2;
        } else {
            fireweapon = isdefined(locations[#"tallfire"][lockey]) ? var_3cbce009 : var_aecaaa11;
        }
        level thread function_42b9fdbe(fireweapon, locations[#"loc"][lockey], locations[#"normal"][lockey], int(5), team);
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 5, eflags: 0x0
// Checksum 0xb6784d6a, Offset: 0x2088
// Size: 0x84
function function_42b9fdbe(weapon, loc, normal, duration, *team) {
    fxnormal = duration;
    wait randomfloatrange(0, 0.5);
    spawntimedfx(loc, normal, fxnormal, team, #"axis");
}

/#

    // Namespace namespace_68a80213/namespace_68a80213
    // Params 5, eflags: 0x0
    // Checksum 0x7f927310, Offset: 0x2118
    // Size: 0xb4
    function incendiary_debug_line(from, to, color, depthtest, time) {
        debug_rcbomb = getdvarint(#"scr_molotov_debug", 0);
        if (debug_rcbomb == 1) {
            if (!isdefined(time)) {
                time = 100;
            }
            if (!isdefined(depthtest)) {
                depthtest = 1;
            }
            line(from, to, color, 1, depthtest, time);
        }
    }

#/

// Namespace namespace_68a80213/namespace_68a80213
// Params 9, eflags: 0x0
// Checksum 0xa32b1482, Offset: 0x21d8
// Size: 0x4d0
function damageeffectarea(position, *normal, weapon, radius_multiplier, var_e76400c0, wallnormal, var_cbaaea69, damageendtime, customsettings) {
    level endon(#"game_ended");
    radius = 65 * radius_multiplier;
    height = 48;
    trigger_radius_position = normal - (0, 0, height);
    trigger_radius_height = height * 2;
    if (isdefined(var_e76400c0) && isdefined(wallnormal)) {
        var_21f4217c = var_e76400c0 + vectorscale(wallnormal, 12) - (0, 0, var_cbaaea69);
        var_289a74bc = spawn("trigger_radius", var_21f4217c, 0, 12, var_cbaaea69);
        /#
            if (getdvarint(#"scr_draw_triggers", 0)) {
                level thread util::drawcylinder(var_21f4217c, 12, var_cbaaea69, undefined, "<dev string:x38>", (1, 0, 0), 0.9);
            }
        #/
    }
    if (radius >= 0.04) {
        fireeffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
        firesound = spawn("script_origin", fireeffectarea.origin);
        if (isdefined(firesound)) {
            firesound playloopsound(#"hash_6993f289f9415bd1");
        }
    }
    /#
        if (getdvarint(#"scr_draw_triggers", 0)) {
            level thread util::drawcylinder(trigger_radius_position, radius, trigger_radius_height, undefined, "<dev string:x38>");
        }
    #/
    self.var_ebf0b1c9 = [];
    burntime = 0;
    var_d0603aba = 1;
    self thread function_1f077104(normal, fireeffectarea, var_289a74bc, weapon, damageendtime);
    while (gettime() < damageendtime) {
        damageapplied = 0;
        potential_targets = self getpotentialtargets();
        foreach (target in potential_targets) {
            self trytoapplyfiredamage(target, normal, fireeffectarea, var_289a74bc, weapon, customsettings);
        }
        wait 0.2;
    }
    arrayremovevalue(self.var_ebf0b1c9, undefined);
    foreach (target in self.var_ebf0b1c9) {
        target.var_84e41b20 = undefined;
        target status_effect::function_408158ef(level.var_5d450296, level.var_e6a4f161);
    }
    if (isdefined(fireeffectarea)) {
        fireeffectarea delete();
        if (isdefined(firesound)) {
            firesound thread stopfiresound();
        }
    }
    if (isdefined(var_289a74bc)) {
        var_289a74bc delete();
    }
    /#
        if (getdvarint(#"scr_draw_triggers", 0)) {
            level notify(#"hash_33d328e380ab0acc");
        }
    #/
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 5, eflags: 0x0
// Checksum 0xa7d8902a, Offset: 0x26b0
// Size: 0x11c
function function_1f077104(position, fireeffectarea, var_289a74bc, weapon, damageendtime) {
    level endon(#"game_ended");
    self endon(#"death");
    while (gettime() < damageendtime) {
        var_9a43d78f = self function_ae0a22c4(position);
        foreach (target in var_9a43d78f) {
            self function_851843a5(target, position, fireeffectarea, var_289a74bc, weapon);
        }
        wait 0.25;
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x0
// Checksum 0x266df21c, Offset: 0x27d8
// Size: 0x54
function stopfiresound() {
    firesound = self;
    firesound stoploopsound(2);
    wait 0.5;
    if (isdefined(firesound)) {
        firesound delete();
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 9, eflags: 0x0
// Checksum 0xba1391ef, Offset: 0x2838
// Size: 0x35c
function function_9464e4ad(position, *normal, weapon, radius_multiplier, var_e76400c0, wallnormal, var_cbaaea69, damageendtime, customsettings) {
    level endon(#"game_ended");
    radius = 65 * radius_multiplier;
    height = 48;
    trigger_radius_position = normal - (0, 0, height);
    trigger_radius_height = height * 2;
    if (isdefined(var_e76400c0) && isdefined(wallnormal)) {
        var_21f4217c = var_e76400c0 + vectorscale(wallnormal, 12) - (0, 0, var_cbaaea69);
        var_289a74bc = spawn("trigger_radius", var_21f4217c, 0, 12, var_cbaaea69);
        var_289a74bc.targetname = "fire_area";
    }
    if (radius >= 0.04) {
        fireeffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
        fireeffectarea.targetname = "fire_area";
    }
    self.var_ebf0b1c9 = [];
    while (gettime() < damageendtime) {
        damageapplied = 0;
        potential_targets = self weapons::function_356292be(undefined, normal, radius);
        foreach (target in potential_targets) {
            self trytoapplyfiredamage(target, normal, fireeffectarea, var_289a74bc, weapon, customsettings);
        }
        wait customsettings.var_8fbd03cb;
    }
    arrayremovevalue(self.var_ebf0b1c9, undefined);
    foreach (target in self.var_ebf0b1c9) {
        target.var_84e41b20 = undefined;
        target status_effect::function_408158ef(level.var_5d450296, level.var_e6a4f161);
    }
    if (isdefined(fireeffectarea)) {
        fireeffectarea delete();
    }
    if (isdefined(var_289a74bc)) {
        var_289a74bc delete();
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 1, eflags: 0x0
// Checksum 0xb8fd4947, Offset: 0x2ba0
// Size: 0x42
function function_ae0a22c4(position) {
    potential_targets = [];
    potential_targets = getentitiesinradius(position, 65, 15);
    return potential_targets;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x0
// Checksum 0xd83f318, Offset: 0x2bf0
// Size: 0x146
function getpotentialtargets() {
    if (level.teambased && level.friendlyfire == 0) {
        potential_targets = [];
        foreach (team, _ in level.teams) {
            potential_targets = arraycombine(potential_targets, getplayers(team), 0, 0);
        }
    }
    all_targets = [];
    all_targets = arraycombine(all_targets, level.players, 0, 0);
    all_targets = arraycombine(all_targets, getaiarray(), 0, 0);
    if (level.friendlyfire > 0) {
        return all_targets;
    }
    return all_targets;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 1, eflags: 0x0
// Checksum 0xa84b543a, Offset: 0x2d40
// Size: 0x162
function function_5a49ebd3(team) {
    scriptmodels = getentarray("script_model", "classname");
    var_e26b971c = [];
    foreach (scriptmodel in scriptmodels) {
        if (!isdefined(scriptmodel)) {
            continue;
        }
        if (!isdefined(scriptmodel.team)) {
            continue;
        }
        if (scriptmodel.health <= 0) {
            continue;
        }
        if (scriptmodel.team == team) {
            if (!isdefined(var_e26b971c)) {
                var_e26b971c = [];
            } else if (!isarray(var_e26b971c)) {
                var_e26b971c = array(var_e26b971c);
            }
            if (!isinarray(var_e26b971c, scriptmodel)) {
                var_e26b971c[var_e26b971c.size] = scriptmodel;
            }
        }
    }
    return var_e26b971c;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 5, eflags: 0x0
// Checksum 0x4d7af704, Offset: 0x2eb0
// Size: 0x1c8
function function_851843a5(target, position, fireeffectarea, var_289a74bc, *weapon) {
    if (!(isdefined(var_289a74bc) || isdefined(weapon))) {
        return;
    }
    var_4c3c1b32 = 0;
    var_75046efd = 0;
    sourcepos = fireeffectarea;
    if (isdefined(var_289a74bc)) {
        var_4c3c1b32 = position istouching(var_289a74bc);
        sourcepos = var_289a74bc.origin;
    }
    if (isdefined(weapon)) {
        var_75046efd = position istouching(weapon);
        sourcepos = weapon.origin;
    }
    var_be45d685 = !(var_4c3c1b32 || var_75046efd);
    targetentnum = position getentitynumber();
    if (!var_be45d685 && (!isdefined(position.sessionstate) || position.sessionstate == "playing")) {
        trace = bullettrace(fireeffectarea, position getshootatpos(), 0, position);
        if (trace[#"fraction"] == 1) {
            if (position.var_9fde8624 === #"hash_28e36e7b7d5421f") {
                position thread function_c049196a();
            }
            return;
        }
        var_be45d685 = 1;
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 6, eflags: 0x0
// Checksum 0x803d77af, Offset: 0x3080
// Size: 0x2cc
function trytoapplyfiredamage(target, position, fireeffectarea, var_289a74bc, weapon, customsettings) {
    if (!(isdefined(fireeffectarea) || isdefined(var_289a74bc))) {
        return;
    }
    var_4c3c1b32 = 0;
    var_75046efd = 0;
    sourcepos = position;
    if (isdefined(fireeffectarea)) {
        var_4c3c1b32 = target istouching(fireeffectarea);
        sourcepos = fireeffectarea.origin;
    }
    if (isdefined(var_289a74bc)) {
        var_75046efd = target istouching(var_289a74bc);
        sourcepos = var_289a74bc.origin;
    }
    var_be45d685 = !(var_4c3c1b32 || var_75046efd);
    targetentnum = target getentitynumber();
    if (!var_be45d685 && (!isdefined(target.sessionstate) || target.sessionstate == "playing")) {
        trace = bullettrace(position, target getshootatpos(), 0, target);
        if (trace[#"fraction"] == 1) {
            if (isplayer(target)) {
                target thread damageinfirearea(sourcepos, trace, position, weapon, fireeffectarea, var_289a74bc, customsettings);
            } else if (isai(target)) {
                target function_8422dabd(sourcepos, trace, position, customsettings);
            } else {
                target thread function_37ddab3(sourcepos, trace, position, weapon, customsettings);
            }
            self.var_ebf0b1c9[targetentnum] = target;
        } else {
            var_be45d685 = 1;
        }
    }
    if (var_be45d685 && isdefined(target.var_84e41b20) && isplayer(target)) {
        if (target.var_84e41b20.size == 0) {
            target.var_84e41b20 = undefined;
            target status_effect::function_408158ef(level.var_5d450296, level.var_e6a4f161);
            self.var_ebf0b1c9[targetentnum] = undefined;
        }
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x0
// Checksum 0xe563cc8e, Offset: 0x3358
// Size: 0x62
function function_c049196a() {
    self endon(#"death");
    t = gettime();
    wait_time = gettime() + 1000;
    if (isdefined(self)) {
        self.var_338d4a29 = 1;
        wait 0.25;
        self.var_338d4a29 = 0;
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 7, eflags: 0x0
// Checksum 0xe9ea0226, Offset: 0x33c8
// Size: 0x1dc
function damageinfirearea(origin, *trace, *position, weapon, fireeffectarea, var_289a74bc, *customsettings) {
    self endon(#"death");
    timer = 0;
    if (candofiredamage(self, 0.2)) {
        /#
            level.molotov_debug = getdvarint(#"scr_molotov_debug", 0);
            if (level.molotov_debug) {
                if (!isdefined(level.incendiarydamagetime)) {
                    level.incendiarydamagetime = gettime();
                }
                iprintlnbold(level.incendiarydamagetime - gettime());
                level.incendiarydamagetime = gettime();
            }
        #/
        if (!isdefined(self.var_84e41b20)) {
            self.var_84e41b20 = [];
        }
        params = getstatuseffect("dot_molotov_dog");
        if (undefined !== self) {
            if (isdefined(var_289a74bc)) {
                self status_effect::status_effect_apply(params, fireeffectarea, var_289a74bc, 0, undefined, undefined, weapon);
                self.var_ae639436 = var_289a74bc;
                self thread sndfiredamage();
                return;
            }
            if (isdefined(customsettings)) {
                self status_effect::status_effect_apply(params, fireeffectarea, customsettings, 0, undefined, undefined, weapon);
                self.var_ae639436 = customsettings;
                self thread sndfiredamage();
            }
        }
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 4, eflags: 0x0
// Checksum 0x9e80b404, Offset: 0x35b0
// Size: 0xb4
function function_8422dabd(*origin, *trace, *position, customsettings) {
    self endon(#"death");
    timer = 0;
    if (candofiredamage(self, customsettings.var_90bd7d92)) {
        if (!isdefined(self.var_84e41b20)) {
            self.var_84e41b20 = [];
        }
        self dodamage(14, self.origin, undefined, undefined, "none", "MOD_BURNED", 0, undefined);
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 5, eflags: 0x0
// Checksum 0x669abf0c, Offset: 0x3670
// Size: 0x10a
function function_37ddab3(*origin, *trace, *position, weapon, customsettings) {
    self endon(#"death");
    timer = 0;
    if (candofiredamage(self, customsettings.var_8fbd03cb)) {
        var_4dd4e6ee = undefined;
        if (!isdefined(self.var_84e41b20)) {
            self.var_84e41b20 = [];
        }
        var_341dfe48 = int(customsettings.var_4931651e * customsettings.var_8fbd03cb);
        self dodamage(var_341dfe48, self.origin, undefined, weapon, "none", "MOD_BURNED", 0, weapon);
        self.var_ae639436 = var_4dd4e6ee;
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 0, eflags: 0x0
// Checksum 0x7391be82, Offset: 0x3788
// Size: 0x14e
function sndfiredamage() {
    self notify(#"sndfire");
    self endon(#"sndfire", #"death", #"disconnect");
    if (!isdefined(self.sndfireent)) {
        self.sndfireent = spawn("script_origin", self.origin);
        self.sndfireent linkto(self, "tag_origin");
        self.sndfireent playsound(#"hash_42d7a7b01bd2b414");
        self thread sndfiredamage_deleteent(self.sndfireent);
    }
    self.sndfireent playloopsound(#"hash_aa65888a78201f4", 0.5);
    wait 3;
    if (isdefined(self.sndfireent)) {
        self.sndfireent delete();
        self.sndfireent = undefined;
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 1, eflags: 0x0
// Checksum 0x265ae186, Offset: 0x38e0
// Size: 0x4c
function sndfiredamage_deleteent(ent) {
    self waittill(#"death", #"disconnect");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 3, eflags: 0x0
// Checksum 0xac6d74db, Offset: 0x3938
// Size: 0xe0
function hitpos(start, end, color) {
    trace = bullettrace(start, end, 0, undefined);
    /#
        level.molotov_debug = getdvarint(#"scr_molotov_debug", 0);
        if (level.molotov_debug) {
            debugstar(trace[#"position"], 2000, color);
        }
        thread incendiary_debug_line(start, trace[#"position"], color, 1, 80);
    #/
    return trace;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 2, eflags: 0x0
// Checksum 0x4008274b, Offset: 0x3a20
// Size: 0xbc
function candofiredamage(victim, resetfiretime) {
    if (isplayer(victim) && victim depthofplayerinwater() >= 1) {
        return false;
    }
    entnum = victim getentitynumber();
    if (!isdefined(level.var_e8a6b3ee[entnum])) {
        level.var_e8a6b3ee[entnum] = 1;
        level thread resetfiredamage(entnum, resetfiretime);
        return true;
    }
    return false;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 2, eflags: 0x0
// Checksum 0xc8974315, Offset: 0x3ae8
// Size: 0x40
function resetfiredamage(entnum, time) {
    if (time > 0.05) {
        wait time - 0.05;
    }
    level.var_e8a6b3ee[entnum] = undefined;
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 5, eflags: 0x0
// Checksum 0xd1ec536f, Offset: 0x3b30
// Size: 0xac
function function_1493c734(origin, radius, color, alpha, time) {
    /#
        debug_fire = getdvarint(#"hash_58042b6209e0c2a6", 0);
        if (debug_fire > 0) {
            if (debug_fire > 1) {
                radius = int(radius / debug_fire);
            }
            util::debug_sphere(origin, radius, color, alpha, time);
        }
    #/
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 2, eflags: 0x4
// Checksum 0x3b2408a3, Offset: 0x3be8
// Size: 0xf8
function private function_ccb2e201(position, radius) {
    a_zombies = getentitiesinradius(position, radius, 15);
    var_eb2cabb5 = array::filter(a_zombies, 0, &function_53811067);
    if (var_eb2cabb5.size > 0) {
        foreach (zombie in var_eb2cabb5) {
            zombie zombie_utility::setup_zombie_knockdown(position);
        }
    }
}

// Namespace namespace_68a80213/namespace_68a80213
// Params 1, eflags: 0x4
// Checksum 0x6343870e, Offset: 0x3ce8
// Size: 0x70
function private function_53811067(zombie) {
    if (!isdefined(zombie)) {
        return false;
    }
    if (zombie.knockdown === 1) {
        return false;
    }
    if (zombie.archetype !== #"zombie") {
        return false;
    }
    if (zombie.var_33fb0350 === 1) {
        return false;
    }
    return true;
}

