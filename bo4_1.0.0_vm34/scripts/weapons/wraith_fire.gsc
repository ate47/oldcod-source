#using scripts\core_common\callbacks_shared;
#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace wraith_fire;

// Namespace wraith_fire/wraith_fire
// Params 0, eflags: 0x2
// Checksum 0x6e8b5242, Offset: 0x1c0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wraith_fire", &init_shared, undefined, undefined);
}

// Namespace wraith_fire/wraith_fire
// Params 0, eflags: 0x0
// Checksum 0x65bd78ca, Offset: 0x208
// Size: 0xc4
function init_shared() {
    params = getstatuseffect("dot_wraith_fire");
    level.var_6af02ebb = params.var_d20b8ed2;
    level.var_e3d517ac = params.setype;
    level.var_9085501f = [];
    level._effect[#"hash_6024e139900c449a"] = #"hash_3937ef26298b6caf";
    weaponobjects::function_f298eae6(#"eq_wraith_fire", &function_5baa801d, 1);
}

// Namespace wraith_fire/wraith_fire
// Params 1, eflags: 0x0
// Checksum 0x43dc7402, Offset: 0x2d8
// Size: 0x26
function function_5baa801d(watcher) {
    watcher.onspawn = &function_67cabeb2;
}

// Namespace wraith_fire/wraith_fire
// Params 2, eflags: 0x0
// Checksum 0xc2a8b2c0, Offset: 0x308
// Size: 0x8c
function function_67cabeb2(watcher, player) {
    player endon(#"death");
    level endon(#"game_ended");
    player stats::function_4f10b697(self.weapon, #"used", 1);
    self thread function_75a2999f(player, self.weapon);
}

// Namespace wraith_fire/wraith_fire
// Params 0, eflags: 0x0
// Checksum 0x594c20cd, Offset: 0x3a0
// Size: 0x2e
function function_5c5d56cd() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"hash_51d0dcaebb5940a5");
}

// Namespace wraith_fire/wraith_fire
// Params 2, eflags: 0x0
// Checksum 0x1712c8a4, Offset: 0x3d8
// Size: 0x244
function function_75a2999f(owner, weapon) {
    self endon(#"hacked", #"hash_51d0dcaebb5940a5");
    assert(isdefined(weapon.customsettings), "<dev string:x30>" + weapon.name);
    self thread function_5c5d56cd();
    team = self.team;
    killcament = spawn("script_model", self.origin);
    killcament util::deleteaftertime(15);
    killcament.starttime = gettime();
    killcament linkto(self);
    killcament setweapon(self.weapon);
    killcament killcam::store_killcam_entity_on_entity(self);
    self thread function_dcc79c6e();
    waitresult = self waittill(#"projectile_impact_explode", #"explode");
    if (waitresult._notify == "projectile_impact_explode") {
        killcament unlink();
        var_55702a54 = !is_under_water(waitresult.position);
        if (var_55702a54) {
            function_7fecaa6(owner, waitresult.position, waitresult.normal, self.var_89542521, killcament, weapon, team, getscriptbundle(weapon.customsettings));
        }
    }
}

// Namespace wraith_fire/wraith_fire
// Params 8, eflags: 0x0
// Checksum 0x890a326, Offset: 0x628
// Size: 0x8c
function function_7fecaa6(owner, origin, normal, velocity, killcament, weapon, team, customsettings) {
    playsoundatposition("", origin);
    self thread function_b0b2a05d(origin, owner, normal, velocity, killcament, weapon, team, customsettings);
}

// Namespace wraith_fire/wraith_fire
// Params 1, eflags: 0x0
// Checksum 0xc93e76b4, Offset: 0x6c0
// Size: 0x44
function is_under_water(position) {
    water_depth = getwaterheight(position) - position[2];
    return water_depth >= 24;
}

// Namespace wraith_fire/wraith_fire
// Params 1, eflags: 0x0
// Checksum 0x6d1a4c02, Offset: 0x710
// Size: 0x24
function function_82348520(water_depth) {
    return 0 < water_depth && water_depth < 24;
}

// Namespace wraith_fire/wraith_fire
// Params 1, eflags: 0x0
// Checksum 0xe76d73ed, Offset: 0x740
// Size: 0x2e
function get_water_depth(position) {
    return getwaterheight(position) - position[2];
}

// Namespace wraith_fire/wraith_fire
// Params 0, eflags: 0x0
// Checksum 0x23e5fd3, Offset: 0x778
// Size: 0x7a
function function_dcc79c6e() {
    self endon(#"projectile_impact_explode", #"death");
    while (true) {
        self.var_89542521 = self getvelocity();
        wait float(function_f9f48566()) / 1000;
    }
}

// Namespace wraith_fire/wraith_fire
// Params 1, eflags: 0x0
// Checksum 0x8fd2363e, Offset: 0x800
// Size: 0x8c
function function_1f68a379(normal) {
    if (normal[2] < 0.5) {
        stepoutdistance = normal * getdvarint(#"hash_4fd125a3b5b9c476", 50);
    } else {
        stepoutdistance = normal * getdvarint(#"hash_49b134352662c4b9", 12);
    }
    return stepoutdistance;
}

// Namespace wraith_fire/wraith_fire
// Params 8, eflags: 0x0
// Checksum 0x23ce040c, Offset: 0x898
// Size: 0x954
function function_b0b2a05d(position, owner, normal, velocity, killcament, weapon, team, customsettings) {
    originalposition = position;
    var_7f651285 = normal;
    var_64a921f0 = vectornormalize(velocity);
    var_4b338ef6 = vectorscale(var_64a921f0, -1);
    var_905444f3 = 1;
    var_a3669cc1 = undefined;
    wallnormal = undefined;
    var_28433d2b = undefined;
    var_9953c833 = getweapon(#"wraith_fire_fire");
    var_6c692663 = getweapon("wraith_fire_fire_wall");
    var_714500d = getweapon("wraith_fire_steam");
    if (normal[2] < -0.5) {
        var_3c1e0026 = position + vectorscale(normal, 2);
        var_9e7a3917 = var_3c1e0026 - (0, 0, 240);
        var_25fe7eef = physicstrace(var_3c1e0026, var_9e7a3917, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), self, 1);
        if (var_25fe7eef[#"fraction"] < 1) {
            position = var_25fe7eef[#"position"];
            if (var_25fe7eef[#"fraction"] > 0) {
                normal = var_25fe7eef[#"normal"];
            } else {
                normal = (0, 0, 1);
            }
            var_2106b589 = 1.2 * var_25fe7eef[#"fraction"];
            var_4b338ef6 = normal;
            if (var_2106b589 > 0) {
                wait var_2106b589;
            }
        } else {
            return;
        }
    } else if (normal[2] < 0.5) {
        var_3c1e0026 = position + vectorscale(var_7f651285, 2);
        var_9e7a3917 = var_3c1e0026 - (0, 0, 20);
        var_25fe7eef = physicstrace(var_3c1e0026, var_9e7a3917, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), self, 1);
        if (var_25fe7eef[#"fraction"] < 1) {
            position = var_3c1e0026;
            if (var_25fe7eef[#"fraction"] > 0) {
                normal = var_25fe7eef[#"normal"];
            } else {
                normal = (0, 0, 1);
            }
        }
    }
    if (normal[2] < 0.5) {
        wall_normal = normal;
        var_3c1e0026 = originalposition + vectorscale(var_7f651285, 8);
        var_9e7a3917 = var_3c1e0026 - (0, 0, 300);
        var_25fe7eef = physicstrace(var_3c1e0026, var_9e7a3917, (-3, -3, -3), (3, 3, 3), self, 1);
        var_28433d2b = var_25fe7eef[#"fraction"] * 300;
        var_f0ba9ab2 = 0;
        if (var_28433d2b > 10) {
            var_a3669cc1 = originalposition;
            wallnormal = var_7f651285;
            var_905444f3 = sqrt(1 - var_25fe7eef[#"fraction"]);
            var_f0ba9ab2 = 1;
        }
        if (var_25fe7eef[#"fraction"] < 1) {
            position = var_25fe7eef[#"position"];
            if (var_25fe7eef[#"fraction"] > 0) {
                normal = var_25fe7eef[#"normal"];
            } else {
                normal = (0, 0, 1);
            }
        }
        if (var_f0ba9ab2) {
            x = originalposition[0];
            y = originalposition[1];
            lowestz = var_25fe7eef[#"position"][2];
            for (z = originalposition[2]; z > lowestz; z -= randomintrange(20, 30)) {
                newpos = (x, y, z);
                water_depth = get_water_depth(newpos);
                if (function_82348520(water_depth) || is_under_water(newpos)) {
                    newpos -= (0, 0, water_depth);
                    level thread function_8046c45f(var_714500d, newpos, (0, 0, 1), int(customsettings.var_6bf07cd0), team);
                    break;
                }
                level thread function_8046c45f(var_6c692663, newpos, wall_normal, int(customsettings.var_6bf07cd0), team);
            }
            var_632ee2c4 = 0.6 * var_25fe7eef[#"fraction"];
            if (var_632ee2c4 > 0) {
                wait var_632ee2c4;
            }
        }
    }
    startpos = position + function_1f68a379(normal);
    desiredendpos = startpos + (0, 0, 60);
    function_db753d43(startpos, 20, (0, 1, 0), 0.6, 200);
    phystrace = physicstrace(startpos, desiredendpos, (-4, -4, -4), (4, 4, 4), self, 1);
    goalpos = phystrace[#"fraction"] > 1 ? desiredendpos : phystrace[#"position"];
    killcament moveto(goalpos, 0.5);
    rotation = randomint(360);
    if (normal[2] < 0.1 && !isdefined(var_a3669cc1)) {
        black = (0.1, 0.1, 0.1);
        trace = hitpos(startpos, startpos + normal * -1 * 70 + (0, 0, -1) * 70, black);
        traceposition = trace[#"position"];
        if (trace[#"fraction"] < 0.9) {
            var_a9242621 = trace[#"normal"];
            spawntimedfx(var_6c692663, traceposition, var_a9242621, int(customsettings.var_6bf07cd0), team);
        }
    }
    var_4b338ef6 = normal;
    level function_96a1af9e(owner, position, startpos, var_4b338ef6, var_905444f3, rotation, killcament, weapon, customsettings, team, var_a3669cc1, wallnormal, var_28433d2b);
}

// Namespace wraith_fire/wraith_fire
// Params 7, eflags: 0x0
// Checksum 0x66717726, Offset: 0x11f8
// Size: 0x98
function function_21ee2b4(startpos, normal, var_16ad8509, fxindex, fxcount, defaultdistance, rotation) {
    currentangle = 360 / fxcount * fxindex;
    var_6c7288d0 = rotatepointaroundaxis(var_16ad8509 * defaultdistance, normal, currentangle + rotation);
    return startpos + var_6c7288d0;
}

// Namespace wraith_fire/wraith_fire
// Params 13, eflags: 0x0
// Checksum 0x63b082c4, Offset: 0x1298
// Size: 0xe68
function function_96a1af9e(owner, impactpos, startpos, normal, multiplier, rotation, killcament, weapon, customsettings, team, var_a3669cc1, wallnormal, var_28433d2b) {
    defaultdistance = customsettings.var_7ee7c802 * multiplier;
    defaultdropdistance = getdvarint(#"hash_4270b8db6cf2ceff", 90);
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
    fxcount = customsettings.var_889c0298;
    var_9ba42fb1 = isdefined(customsettings.var_8a277570) ? customsettings.var_8a277570 : 0;
    fxcount = int(math::clamp(fxcount * multiplier + 6, 6, customsettings.var_889c0298));
    if (multiplier < 0.04) {
        fxcount = 0;
    }
    var_16ad8509 = perpendicularvector(normal);
    for (fxindex = 0; fxindex < fxcount; fxindex++) {
        locations[#"point"][fxindex] = function_21ee2b4(startpos, normal, var_16ad8509, fxindex, fxcount, defaultdistance, rotation);
        function_db753d43(locations[#"point"][fxindex], 10, (0, fxindex * 20, 0), 0.6, 200);
        locations[#"color"][fxindex] = colorarray[fxindex % colorarray.size];
    }
    var_2202d214 = normal[2] > 0.5;
    for (count = 0; count < fxcount; count++) {
        trace = hitpos(startpos, locations[#"point"][count], locations[#"color"][count]);
        traceposition = trace[#"position"];
        locations[#"tracepos"][count] = traceposition;
        hitsomething = 0;
        if (trace[#"fraction"] < 0.7) {
            function_db753d43(traceposition, 10, (1, 0, 0), 0.6, 200);
            locations[#"loc"][count] = traceposition;
            locations[#"normal"][count] = trace[#"normal"];
            if (var_2202d214) {
                locations[#"tallfire"][count] = 1;
            }
            hitsomething = 1;
        }
        if (!hitsomething) {
            tracedown = hitpos(traceposition, traceposition - normal * defaultdropdistance, locations[#"color"][count]);
            if (tracedown[#"fraction"] != 1) {
                function_db753d43(tracedown[#"position"], 10, (0, 0, 1), 0.6, 200);
                locations[#"loc"][count] = tracedown[#"position"];
                water_depth = get_water_depth(tracedown[#"position"]);
                if (function_82348520(water_depth)) {
                    locations[#"normal"][count] = (0, 0, 1);
                    locations[#"steam"][count] = 1;
                    locations[#"loc"][count] = locations[#"loc"][count] - (0, 0, water_depth);
                } else {
                    locations[#"normal"][count] = tracedown[#"normal"];
                    locations[#"smallfire"][count] = 1;
                }
            }
        }
        randangle = randomint(360);
        var_9d943a54 = randomfloatrange(-25, 25);
        var_6c7288d0 = rotatepointaroundaxis(var_16ad8509, normal, randangle);
        var_7cd6c6c = int(min(var_9ba42fb1 * multiplier * trace[#"fraction"] + 1, var_9ba42fb1));
        for (var_2aab4ace = 0; var_2aab4ace < var_7cd6c6c && count % 2 == 0; var_2aab4ace++) {
            fraction = (var_2aab4ace + 1) / (var_7cd6c6c + 1);
            offsetpoint = startpos + (traceposition - startpos) * fraction + var_6c7288d0 * var_9d943a54;
            var_cddaefeb = hitpos(offsetpoint, offsetpoint - normal * defaultdropdistance, locations[#"color"][count]);
            if (var_cddaefeb[#"fraction"] != 1) {
                function_db753d43(var_cddaefeb[#"position"], 10, (0, 0, 1), 0.6, 200);
                locindex = count + fxcount * (var_2aab4ace + 1);
                locations[#"loc"][locindex] = var_cddaefeb[#"position"];
                water_depth = get_water_depth(var_cddaefeb[#"position"]);
                if (function_82348520(water_depth)) {
                    locations[#"normal"][locindex] = (0, 0, 1);
                    locations[#"steam"][locindex] = 1;
                    locations[#"loc"][locindex] = locations[#"loc"][locindex] - (0, 0, water_depth);
                    continue;
                }
                locations[#"normal"][locindex] = var_cddaefeb[#"normal"];
            }
        }
    }
    var_9953c833 = getweapon(#"wraith_fire_fire");
    var_c5e07fd2 = getweapon("wraith_fire_fire_tall");
    var_c85a3970 = getweapon("wraith_fire_fire_small");
    var_714500d = getweapon("wraith_fire_steam");
    var_83dd3809 = impactpos + normal * 1.5;
    forward = (1, 0, 0);
    if (abs(vectordot(forward, normal)) > 0.999) {
        forward = (0, 0, 1);
    }
    if (!is_under_water(var_83dd3809)) {
        playfx(level._effect[#"hash_6024e139900c449a"], var_83dd3809, forward, normal, 0, team);
        if (!isdefined(var_a3669cc1)) {
            spawntimedfx(var_9953c833, var_83dd3809, normal, int(customsettings.var_6bf07cd0), team);
        }
    }
    if (level.gameended) {
        return;
    }
    thread damageeffectarea(owner, startpos, killcament, normal, var_9953c833, customsettings, multiplier, var_a3669cc1, wallnormal, var_28433d2b);
    thread function_1067f0d6(owner, startpos, killcament, normal, var_9953c833, customsettings, multiplier, var_a3669cc1, wallnormal, var_28433d2b);
    var_44990c61 = getarraykeys(locations[#"loc"]);
    foreach (lockey in var_44990c61) {
        if (!isdefined(lockey)) {
            continue;
        }
        if (is_under_water(locations[#"loc"][lockey])) {
            continue;
        }
        if (isdefined(locations[#"smallfire"][lockey])) {
            fireweapon = var_c85a3970;
        } else if (isdefined(locations[#"steam"][lockey])) {
            fireweapon = var_714500d;
        } else {
            fireweapon = isdefined(locations[#"tallfire"][lockey]) ? var_c5e07fd2 : var_9953c833;
        }
        level thread function_8046c45f(fireweapon, locations[#"loc"][lockey], locations[#"normal"][lockey], int(customsettings.var_6bf07cd0), team);
    }
}

// Namespace wraith_fire/wraith_fire
// Params 5, eflags: 0x0
// Checksum 0xfcde8230, Offset: 0x2108
// Size: 0x84
function function_8046c45f(weapon, loc, normal, duration, team) {
    fxnormal = normal;
    wait randomfloatrange(0, 0.5);
    spawntimedfx(weapon, loc, fxnormal, duration, team);
}

/#

    // Namespace wraith_fire/wraith_fire
    // Params 5, eflags: 0x0
    // Checksum 0xd95a496b, Offset: 0x2198
    // Size: 0xb4
    function incendiary_debug_line(from, to, color, depthtest, time) {
        debug_rcbomb = getdvarint(#"hash_75de04766593ca0c", 0);
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

// Namespace wraith_fire/wraith_fire
// Params 10, eflags: 0x0
// Checksum 0x618f707f, Offset: 0x2258
// Size: 0x658
function damageeffectarea(owner, position, killcament, normal, weapon, customsettings, radius_multiplier, var_a3669cc1, wallnormal, var_11a4a021) {
    level endon(#"game_ended");
    radius = customsettings.var_7ee7c802 * radius_multiplier;
    height = customsettings.var_6eed3071;
    trigger_radius_position = position - (0, 0, height);
    trigger_radius_height = height * 2;
    if (isdefined(var_a3669cc1) && isdefined(wallnormal)) {
        var_83d060fd = var_a3669cc1 + vectorscale(wallnormal, 12) - (0, 0, var_11a4a021);
        var_9f36c6a7 = spawn("trigger_radius", var_83d060fd, 0, 12, var_11a4a021);
        /#
            if (getdvarint(#"scr_draw_triggers", 0)) {
                level thread util::drawcylinder(var_83d060fd, 12, var_11a4a021, undefined, "<dev string:x6e>", (1, 0, 0), 0.9);
            }
        #/
    }
    if (radius >= 0.04) {
        fireeffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
        firesound = spawn("script_origin", fireeffectarea.origin);
        firesound playloopsound(#"hash_bdb30092e9dc406");
        level thread influencers::create_grenade_influencers(owner.team, weapon, fireeffectarea);
    }
    /#
        if (getdvarint(#"scr_draw_triggers", 0)) {
            level thread util::drawcylinder(trigger_radius_position, radius, trigger_radius_height, undefined, "<dev string:x6e>");
        }
    #/
    self.var_3c965909 = [];
    burntime = 0;
    var_580e111 = 1;
    damageendtime = int(gettime() + customsettings.var_6bf07cd0 * 1000);
    while (gettime() < damageendtime) {
        damageapplied = 0;
        potential_targets = self getpotentialtargets(owner, customsettings);
        if (isdefined(owner)) {
            owner.var_60aa780b = [];
        }
        foreach (target in potential_targets) {
            self trytoapplyfiredamage(target, owner, position, fireeffectarea, var_9f36c6a7, killcament, weapon, customsettings);
        }
        if (isdefined(owner)) {
            affectedplayers = owner.var_60aa780b.size;
            if (affectedplayers > 0 && burntime < gettime()) {
                burntime = gettime() + int(customsettings.var_87ab51ee * 1000);
            }
            if (isdefined(level.playgadgetsuccess) && var_580e111) {
                if (isdefined(level.var_86ebfbc0)) {
                    var_848752a7 = [[ level.var_86ebfbc0 ]]("wraith_fireSuccessLineCount", 0);
                }
                if (affectedplayers >= (isdefined(var_848752a7) ? var_848752a7 : 3)) {
                    owner [[ level.playgadgetsuccess ]](weapon);
                }
            }
            if (var_580e111) {
                var_580e111 = 0;
            }
        }
        wait customsettings.var_509984dd;
    }
    arrayremovevalue(self.var_3c965909, undefined);
    foreach (target in self.var_3c965909) {
        target.var_2c8df96 = undefined;
        target status_effect::function_280d8ac0(level.var_e3d517ac, level.var_6af02ebb);
    }
    if (isdefined(owner)) {
        owner.var_60aa780b = [];
    }
    if (isdefined(killcament)) {
        killcament entityheadicons::destroyentityheadicons();
    }
    if (isdefined(fireeffectarea)) {
        fireeffectarea delete();
        firesound thread stopfiresound();
    }
    if (isdefined(var_9f36c6a7)) {
        var_9f36c6a7 delete();
    }
    /#
        if (getdvarint(#"scr_draw_triggers", 0)) {
            level notify(#"hash_67e730c2519446");
        }
    #/
}

// Namespace wraith_fire/wraith_fire
// Params 0, eflags: 0x0
// Checksum 0x8f7b0214, Offset: 0x28b8
// Size: 0x54
function stopfiresound() {
    firesound = self;
    firesound stoploopsound(2);
    wait 0.5;
    if (isdefined(firesound)) {
        firesound delete();
    }
}

// Namespace wraith_fire/wraith_fire
// Params 10, eflags: 0x0
// Checksum 0x72384aaf, Offset: 0x2918
// Size: 0x3b4
function function_1067f0d6(owner, position, killcament, normal, weapon, customsettings, radius_multiplier, var_a3669cc1, wallnormal, var_11a4a021) {
    level endon(#"game_ended");
    radius = customsettings.var_7ee7c802 * radius_multiplier;
    height = customsettings.var_6eed3071;
    trigger_radius_position = position - (0, 0, height);
    trigger_radius_height = height * 2;
    if (isdefined(var_a3669cc1) && isdefined(wallnormal)) {
        var_83d060fd = var_a3669cc1 + vectorscale(wallnormal, 12) - (0, 0, var_11a4a021);
        var_9f36c6a7 = spawn("trigger_radius", var_83d060fd, 0, 12, var_11a4a021);
    }
    if (radius >= 0.04) {
        fireeffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
    }
    self.var_3c965909 = [];
    damageendtime = int(gettime() + customsettings.var_6bf07cd0 * 1000);
    while (gettime() < damageendtime) {
        damageapplied = 0;
        potential_targets = self function_9f82299c(owner, customsettings, trigger_radius_position, radius);
        foreach (target in potential_targets) {
            self trytoapplyfiredamage(target, owner, position, fireeffectarea, var_9f36c6a7, killcament, weapon, customsettings);
        }
        wait customsettings.var_8b1dd940;
    }
    arrayremovevalue(self.var_3c965909, undefined);
    foreach (target in self.var_3c965909) {
        target.var_2c8df96 = undefined;
        target status_effect::function_280d8ac0(level.var_e3d517ac, level.var_6af02ebb);
    }
    if (isdefined(owner)) {
        owner globallogic_score::function_8fe8d71e(#"hash_775faa6097bd0ccc");
    }
    if (isdefined(fireeffectarea)) {
        fireeffectarea delete();
    }
    if (isdefined(var_9f36c6a7)) {
        var_9f36c6a7 delete();
    }
}

// Namespace wraith_fire/wraith_fire
// Params 2, eflags: 0x0
// Checksum 0xf134b6e8, Offset: 0x2cd8
// Size: 0x29e
function getpotentialtargets(owner, customsettings) {
    owner_team = isdefined(owner) ? owner.team : undefined;
    if (level.teambased && isdefined(owner_team) && level.friendlyfire == 0) {
        enemy_team = owner_team == #"axis" ? #"allies" : #"axis";
        potential_targets = [];
        potential_targets = arraycombine(potential_targets, getplayers(enemy_team), 0, 0);
        if (customsettings.var_78a4406a === 1) {
            potential_targets[potential_targets.size] = owner;
        }
        if (customsettings.var_ffbc30dc === 1) {
            potential_targets = arraycombine(potential_targets, getplayers(owner_team), 0, 0);
        }
        return potential_targets;
    }
    all_targets = [];
    all_targets = arraycombine(all_targets, level.players, 0, 0);
    if (level.friendlyfire > 0) {
        return all_targets;
    }
    potential_targets = [];
    foreach (target in all_targets) {
        if (!isdefined(target)) {
            continue;
        }
        if (!isdefined(target.team)) {
            continue;
        }
        if (isdefined(owner)) {
            if (target != owner) {
                if (!isdefined(owner_team)) {
                    continue;
                }
                if (target.team == owner_team) {
                    continue;
                }
            }
        } else {
            if (!isdefined(self)) {
                continue;
            }
            if (!isdefined(self.team)) {
                continue;
            }
            if (target.team == self.team) {
                continue;
            }
        }
        potential_targets[potential_targets.size] = target;
    }
    return potential_targets;
}

// Namespace wraith_fire/wraith_fire
// Params 1, eflags: 0x0
// Checksum 0xc7bcab5d, Offset: 0x2f80
// Size: 0x160
function function_477d1aa8(team) {
    scriptmodels = getentarray("script_model", "classname");
    var_89d12f36 = [];
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
            if (!isdefined(var_89d12f36)) {
                var_89d12f36 = [];
            } else if (!isarray(var_89d12f36)) {
                var_89d12f36 = array(var_89d12f36);
            }
            if (!isinarray(var_89d12f36, scriptmodel)) {
                var_89d12f36[var_89d12f36.size] = scriptmodel;
            }
        }
    }
    return var_89d12f36;
}

// Namespace wraith_fire/wraith_fire
// Params 4, eflags: 0x0
// Checksum 0xc57190f7, Offset: 0x30e8
// Size: 0x356
function function_9f82299c(owner, customsettings, origin, radius) {
    owner_team = isdefined(owner) ? owner.team : undefined;
    if (level.teambased && isdefined(owner_team) && level.friendlyfire == 0) {
        enemy_team = owner_team == #"axis" ? #"allies" : #"axis";
        potential_targets = [];
        potential_targets = arraycombine(potential_targets, getvehicleteamarray(enemy_team), 0, 0);
        potential_targets = arraycombine(potential_targets, getaiteamarray(enemy_team), 0, 0);
        potential_targets = arraycombine(potential_targets, function_477d1aa8(enemy_team), 0, 0);
        if (isdefined(level.missileentities) && level.missileentities.size > 0) {
            var_646145d3 = owner getentitiesinrange(level.missileentities, int(radius), origin);
            potential_targets = arraycombine(potential_targets, var_646145d3, 0, 0);
        }
        return potential_targets;
    }
    all_targets = [];
    all_targets = arraycombine(all_targets, getvehiclearray(), 0, 0);
    all_targets = arraycombine(all_targets, getaiarray(), 0, 0);
    if (level.friendlyfire > 0) {
        return all_targets;
    }
    potential_targets = [];
    foreach (target in all_targets) {
        if (!isdefined(target)) {
            continue;
        }
        if (!isdefined(target.team)) {
            continue;
        }
        if (isdefined(owner)) {
            if (target != owner) {
                if (!isdefined(owner_team)) {
                    continue;
                }
                if (target.team == owner_team) {
                    continue;
                }
            }
        } else {
            if (!isdefined(self)) {
                continue;
            }
            if (!isdefined(self.team)) {
                continue;
            }
            if (target.team == self.team) {
                continue;
            }
        }
        potential_targets[potential_targets.size] = target;
    }
    return potential_targets;
}

// Namespace wraith_fire/wraith_fire
// Params 8, eflags: 0x0
// Checksum 0x375fa183, Offset: 0x3448
// Size: 0x330
function trytoapplyfiredamage(target, owner, position, fireeffectarea, var_9f36c6a7, killcament, weapon, customsettings) {
    if (!(isdefined(fireeffectarea) || isdefined(var_9f36c6a7))) {
        return;
    }
    var_e9834ece = 0;
    var_9d085288 = 0;
    sourcepos = position;
    if (isdefined(fireeffectarea)) {
        var_e9834ece = target istouching(fireeffectarea);
        sourcepos = fireeffectarea.origin;
    }
    if (isdefined(var_9f36c6a7)) {
        var_9d085288 = target istouching(var_9f36c6a7);
        sourcepos = var_9f36c6a7.origin;
    }
    var_a27daaef = !(var_e9834ece || var_9d085288);
    targetentnum = target getentitynumber();
    if (!var_a27daaef && (!isdefined(target.sessionstate) || target.sessionstate == "playing")) {
        trace = bullettrace(position, target getshootatpos(), 0, target);
        if (trace[#"fraction"] == 1) {
            if (isplayer(target)) {
                target thread damageinfirearea(sourcepos, killcament, trace, position, weapon, customsettings, owner);
                if (isdefined(owner) && target.team != owner.team) {
                    owner.var_60aa780b[targetentnum] = target;
                }
            } else {
                target thread function_81d9b544(sourcepos, killcament, trace, position, weapon, customsettings, owner);
            }
            self.var_3c965909[targetentnum] = target;
        } else {
            var_a27daaef = 1;
        }
    }
    if (var_a27daaef && isdefined(target.var_2c8df96) && isplayer(target)) {
        if (target.var_2c8df96.size == 0) {
            target.var_2c8df96 = undefined;
            target status_effect::function_280d8ac0(level.var_e3d517ac, level.var_6af02ebb);
            self.var_3c965909[targetentnum] = undefined;
        } else {
            target.var_2c8df96[killcament.starttime] = undefined;
        }
        owner.var_60aa780b[targetentnum] = undefined;
    }
}

// Namespace wraith_fire/wraith_fire
// Params 7, eflags: 0x0
// Checksum 0xc0dd789c, Offset: 0x3780
// Size: 0x1c4
function damageinfirearea(origin, killcament, trace, position, weapon, customsettings, owner) {
    self endon(#"death");
    timer = 0;
    if (candofiredamage(killcament, self, customsettings.var_509984dd)) {
        /#
            level.var_99fe5537 = getdvarint(#"hash_75de04766593ca0c", 0);
            if (level.var_99fe5537) {
                if (!isdefined(level.incendiarydamagetime)) {
                    level.incendiarydamagetime = gettime();
                }
                iprintlnbold(level.incendiarydamagetime - gettime());
                level.incendiarydamagetime = gettime();
            }
        #/
        var_965c2006 = owner;
        if (!isdefined(self.var_2c8df96)) {
            self.var_2c8df96 = [];
        }
        self.var_2c8df96[killcament.starttime] = 1;
        params = getstatuseffect("dot_wraith_fire");
        params.killcament = killcament;
        self status_effect::status_effect_apply(params, weapon, owner, 0, undefined, undefined, origin);
        self.var_7a92944c = var_965c2006;
        self thread sndfiredamage();
    }
}

// Namespace wraith_fire/wraith_fire
// Params 7, eflags: 0x0
// Checksum 0x2b1a00b8, Offset: 0x3950
// Size: 0x14a
function function_81d9b544(origin, killcament, trace, position, weapon, customsettings, owner) {
    self endon(#"death");
    timer = 0;
    if (candofiredamage(killcament, self, customsettings.var_8b1dd940)) {
        var_965c2006 = owner;
        if (!isdefined(self.var_2c8df96)) {
            self.var_2c8df96 = [];
        }
        self.var_2c8df96[killcament.starttime] = 1;
        var_71435537 = int(customsettings.var_226a848a * customsettings.var_8b1dd940);
        self dodamage(var_71435537, self.origin, owner, weapon, "none", "MOD_BURNED", 0, weapon);
        self.var_7a92944c = var_965c2006;
    }
}

// Namespace wraith_fire/wraith_fire
// Params 0, eflags: 0x0
// Checksum 0xc5ea2a22, Offset: 0x3aa8
// Size: 0x12e
function sndfiredamage() {
    self notify(#"sndfire");
    self endon(#"death", #"sndfire");
    if (!isdefined(self.sndfireent)) {
        self.sndfireent = spawn("script_origin", self.origin);
        self.sndfireent linkto(self, "tag_origin");
        self.sndfireent playsound(#"chr_burn_start");
        self thread sndfiredamage_deleteent(self.sndfireent);
    }
    self.sndfireent playloopsound(#"chr_burn_start_loop", 0.5);
    wait 3;
    self.sndfireent delete();
    self.sndfireent = undefined;
}

// Namespace wraith_fire/wraith_fire
// Params 1, eflags: 0x0
// Checksum 0x59c3dc34, Offset: 0x3be0
// Size: 0x4c
function sndfiredamage_deleteent(ent) {
    self endon(#"disconnect");
    self waittill(#"death");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace wraith_fire/wraith_fire
// Params 3, eflags: 0x0
// Checksum 0x8c762229, Offset: 0x3c38
// Size: 0xf0
function hitpos(start, end, color) {
    trace = bullettrace(start, end, 0, undefined);
    /#
        level.var_99fe5537 = getdvarint(#"hash_75de04766593ca0c", 0);
        if (level.var_99fe5537) {
            debugstar(trace[#"position"], 2000, color);
        }
        thread incendiary_debug_line(start, trace[#"position"], color, 1, 80);
    #/
    return trace;
}

// Namespace wraith_fire/wraith_fire
// Params 3, eflags: 0x0
// Checksum 0xac09acac, Offset: 0x3d30
// Size: 0xc4
function candofiredamage(killcament, victim, resetfiretime) {
    if (isplayer(victim) && victim depthofplayerinwater() >= 1) {
        return false;
    }
    entnum = victim getentitynumber();
    if (!isdefined(level.var_9085501f[entnum])) {
        level.var_9085501f[entnum] = 1;
        level thread resetfiredamage(entnum, resetfiretime);
        return true;
    }
    return false;
}

// Namespace wraith_fire/wraith_fire
// Params 2, eflags: 0x0
// Checksum 0x1993e478, Offset: 0x3e00
// Size: 0x44
function resetfiredamage(entnum, time) {
    if (time > 0.05) {
        wait time - 0.05;
    }
    level.var_9085501f[entnum] = undefined;
}

// Namespace wraith_fire/wraith_fire
// Params 5, eflags: 0x0
// Checksum 0xfcc2af87, Offset: 0x3e50
// Size: 0xb4
function function_db753d43(origin, radius, color, alpha, time) {
    /#
        debug_fire = getdvarint(#"hash_66232b46a7e21dec", 0);
        if (debug_fire > 0) {
            if (debug_fire > 1) {
                radius = int(radius / debug_fire);
            }
            util::debug_sphere(origin, radius, color, alpha, time);
        }
    #/
}

