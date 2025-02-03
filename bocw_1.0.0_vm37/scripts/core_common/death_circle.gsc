#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\map;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace death_circle;

// Namespace death_circle/death_circle
// Params 0, eflags: 0x6
// Checksum 0xeaa58357, Offset: 0x2d0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"death_circle", &preinit, undefined, undefined, undefined);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0xb096416d, Offset: 0x318
// Size: 0x314
function private preinit() {
    if (!isdefined(level.deathcircle)) {
        level.deathcircle = {};
    }
    level.deathcircle.enabled = currentsessionmode() != 4 && is_true(getgametypesetting(#"deathcircle"));
    level.deathcircles = [];
    level.deathcircle.delaysec = 0;
    level.deathcircle.var_d60fd7cd = 0;
    level.deathcircle.players = [];
    level.deathcircle.timescale = getdvarfloat(#"deathcircle_timescale", 1);
    level.deathcircle.var_4b31458 = getdvarfloat(#"hash_69ae65ef32a36959", 1);
    level.deathcircle.var_473f2707 = getdvarfloat(#"hash_263e72f970ac144d", 1);
    if (!level.deathcircle.enabled) {
        return;
    }
    clientfield::register("scriptmover", "deathcircleflag", 1, 1, "int");
    clientfield::register("toplayer", "deathcircleeffects", 1, 2, "int");
    clientfield::register("allplayers", "outsidedeathcircle", 1, 1, "int");
    clientfield::register("allplayers", "deathcircleopacityflag", 1, 1, "counter");
    clientfield::function_5b7d846d("hudItems.warzone.collapseTimerState", 1, 2, "int");
    clientfield::function_5b7d846d("hudItems.warzone.collapseProgress", 1, 7, "float");
    clientfield::register_clientuimodel("hudItems.distanceFromDeathCircle", 1, 7, "float", 0);
    callback::on_game_playing(&start);
    /#
        level.var_47947565 = [];
        level.var_475c53d7 = [];
        level thread devgui_loop();
        level thread debug_loop();
    #/
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x5fb00f72, Offset: 0x638
// Size: 0x15c
function init() {
    if (!is_true(level.deathcircle.enabled)) {
        return;
    }
    if (is_true(level.deathcircle.var_e5922ac7)) {
        return;
    }
    if (level.deathcircles.size > 0) {
        return;
    }
    deathcircleindex = isdefined(getgametypesetting(#"hash_70072ee20a43ae21")) ? getgametypesetting(#"hash_70072ee20a43ae21") : 0;
    mapbundle = map::get_script_bundle();
    if (isdefined(mapbundle) && isarray(mapbundle.deathcirclelist) && deathcircleindex < mapbundle.deathcirclelist.size) {
        var_ae6c2bbe = getscriptbundle(mapbundle.deathcirclelist[deathcircleindex].var_47fd5ad2);
        level function_5e412e4a(var_ae6c2bbe);
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x6652d827, Offset: 0x7a0
// Size: 0x246
function function_5e412e4a(var_ae6c2bbe) {
    if (!is_true(level.deathcircle.enabled)) {
        return;
    }
    function_d81873aa(isdefined(var_ae6c2bbe.var_64232072) ? var_ae6c2bbe.var_64232072 : 1);
    level.deathcircle.var_cb3d0e42 = isdefined(var_ae6c2bbe.var_8d8aa969) ? var_ae6c2bbe.var_8d8aa969 : 0;
    level.deathcircle.var_edd891a7 = isdefined(var_ae6c2bbe.var_a2c3faa3) ? var_ae6c2bbe.var_a2c3faa3 : 0;
    level.deathcircle.var_672f2d98 = isdefined(var_ae6c2bbe.var_672f2d98) ? var_ae6c2bbe.var_672f2d98 : 0;
    function_114f128a(isdefined(var_ae6c2bbe.var_904b645e) ? var_ae6c2bbe.var_904b645e : 0);
    level.var_6c870a00 = isdefined(var_ae6c2bbe.var_6c870a00) ? var_ae6c2bbe.var_6c870a00 : 10;
    level.var_ab9cd581 = isdefined(var_ae6c2bbe.var_ab9cd581) ? var_ae6c2bbe.var_ab9cd581 : 20;
    function_90aaa085(var_ae6c2bbe);
    if (!level shuffle_circles()) {
        foreach (circle in level.deathcircles) {
            circle.origin = circle.var_3b9f4abf;
            /#
                circle.tracepos = undefined;
            #/
        }
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x6182c645, Offset: 0x9f0
// Size: 0x15a
function private function_90aaa085(var_ae6c2bbe) {
    var_7aa7cb54 = undefined;
    foreach (circle in var_ae6c2bbe.deathcirclelist) {
        var_b9aec05c = isdefined(circle.var_b9aec05c) ? circle.var_b9aec05c : 0;
        var_112f6f50 = isdefined(circle.var_112f6f50) ? circle.var_112f6f50 : 0;
        origin = (var_b9aec05c, var_112f6f50, 0);
        var_7aa7cb54 = add_circle(origin, circle.var_95437170, circle.var_a3841ae2, circle.circleradius, circle.circledamage, circle.var_5a8689a9, circle.circledelay, circle.var_24ae2e27, circle.var_1dfb1051, circle.var_96584cff, circle.var_b97ecd26);
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x3b1e9a90, Offset: 0xb58
// Size: 0x21e
function private function_130c92ab(finalcircle) {
    var_52a6b3a = struct::get_array(#"hash_39f96305bd3fed10", "variantname");
    var_f20eaa57 = [];
    foreach (area in var_52a6b3a) {
        if (getdvarint(area.targetname, 0)) {
            var_f20eaa57[var_f20eaa57.size] = area;
        }
    }
    if (var_f20eaa57.size <= 0) {
        if (isdefined(finalcircle.defaultorigin)) {
            finalcircle.var_3b9f4abf = finalcircle.defaultorigin;
            finalcircle.mapwidth = finalcircle.defaultwidth;
            finalcircle.mapheight = finalcircle.defaultheight;
        }
        return;
    }
    var_32607106 = var_f20eaa57[randomint(var_f20eaa57.size)];
    assert(isdefined(var_32607106.width), "<dev string:x38>");
    assert(isdefined(var_32607106.height), "<dev string:x6b>");
    if (!isdefined(finalcircle.defaultorigin)) {
        finalcircle.defaultorigin = finalcircle.var_3b9f4abf;
        finalcircle.defaultwidth = finalcircle.mapwidth;
        finalcircle.defaultheight = finalcircle.mapheight;
    }
    finalcircle.var_3b9f4abf = var_32607106.origin;
    finalcircle.mapwidth = var_32607106.width;
    finalcircle.mapheight = var_32607106.height;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x763f56a8, Offset: 0xd80
// Size: 0x18
function is_active() {
    return isdefined(level.deathcircle.var_5c54ab33);
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x41c0a120, Offset: 0xda0
// Size: 0x86
function function_65cb78e7(origin) {
    if (!is_active()) {
        return 0;
    }
    return distance2dsquared(origin, level.deathcircle.var_5c54ab33.origin) - level.deathcircle.var_5c54ab33.radius * level.deathcircle.var_5c54ab33.radius;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x84dcedce, Offset: 0xe30
// Size: 0x3a
function function_3009b78f() {
    if (!isdefined(level.deathcircle.var_46fc3d6e)) {
        return undefined;
    }
    return level.deathcircle.var_46fc3d6e.radius;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x4ea5ef6, Offset: 0xe78
// Size: 0x3a
function function_e32d74d8() {
    if (!isdefined(level.deathcircle.var_46fc3d6e)) {
        return undefined;
    }
    return level.deathcircle.var_46fc3d6e.origin;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x863beb38, Offset: 0xec0
// Size: 0x3a
function function_f8dae197() {
    if (!is_active()) {
        return 0;
    }
    return level.deathcircle.var_5c54ab33.radius;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0xff53f45f, Offset: 0xf08
// Size: 0x36
function function_b980b4ca() {
    if (!is_active()) {
        return (0, 0, 0);
    }
    return level.deathcircle.var_5c54ab33.origin;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0xea86ae1b, Offset: 0xf48
// Size: 0x46
function get_next_origin() {
    if (!isdefined(level.deathcircle.nextcircle)) {
        return function_b980b4ca();
    }
    return level.deathcircle.nextcircle.origin;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x429e8d7e, Offset: 0xf98
// Size: 0x42
function function_b1565133() {
    if (!is_active()) {
        return 0;
    }
    return is_true(level.deathcircle.var_5c54ab33.scaling);
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x0
// Checksum 0xe1f85a20, Offset: 0xfe8
// Size: 0x8c
function function_8978c48a(damage, origin) {
    if (!isdefined(level.deathcircle.var_5c54ab33)) {
        self dodamage(damage, origin, undefined, undefined, undefined, "MOD_DEATH_CIRCLE");
        return;
    }
    self dodamage(damage, origin, level.deathcircle.var_5c54ab33, undefined, undefined, "MOD_DEATH_CIRCLE");
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x43e24682, Offset: 0x1080
// Size: 0x6e
function function_d81873aa(delaysec) {
    assert(delaysec >= 0, "<dev string:x9f>" + "<dev string:xc2>");
    delaysec *= level.deathcircle.var_473f2707;
    level.deathcircle.delaysec = delaysec;
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x428655cc, Offset: 0x10f8
// Size: 0x6e
function function_114f128a(delaysec) {
    assert(delaysec >= 0, "<dev string:xe6>" + "<dev string:xc2>");
    delaysec *= level.deathcircle.var_473f2707;
    level.deathcircle.var_672f2d98 = delaysec;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x73dae62, Offset: 0x1170
// Size: 0x36
function function_c156630d() {
    if (!isdefined(level.deathcircle)) {
        level.deathcircle = {};
    }
    level.deathcircle.var_e5922ac7 = 1;
}

// Namespace death_circle/death_circle
// Params 11, eflags: 0x0
// Checksum 0xaa11718a, Offset: 0x11b0
// Size: 0x2b8
function add_circle(var_3b9f4abf, mapwidth = 0, mapheight = 0, radius = 0, damage = 0, damageinterval = 0, waitsec = 0, scalesec = 0, var_55ad5e4 = 0, var_c3bf31b = 0, var_18fa918d = 0) {
    assert(radius <= 150000, "<dev string:x10a>" + "<dev string:x126>" + radius + "<dev string:x133>" + 150000);
    var_55ad5e4 = int(var_55ad5e4 * 1000);
    var_c3bf31b = int(var_c3bf31b * 1000);
    waitsec *= level.deathcircle.var_4b31458;
    scalesec *= level.deathcircle.timescale;
    circle = {#var_3b9f4abf:var_3b9f4abf, #mapwidth:mapwidth, #mapheight:mapheight, #origin:var_3b9f4abf, #radius:radius, #radiussq:radius * radius, #damage:damage, #damageinterval:damageinterval, #waitsec:waitsec, #scalesec:scalesec, #var_55ad5e4:var_55ad5e4, #var_c3bf31b:var_c3bf31b, #var_18fa918d:var_18fa918d};
    level.deathcircles[level.deathcircles.size] = circle;
    return circle;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0x6e8fb43f, Offset: 0x1470
// Size: 0x1d0
function private shuffle_circles() {
    var_b0b91d4 = level.deathcircles[0];
    if (!isdefined(var_b0b91d4)) {
        return false;
    }
    finalindex = level.deathcircles.size - 1;
    finalcircle = level.deathcircles[finalindex];
    attempts = 0;
    while (attempts < 20) {
        attempts++;
        if (var_b0b91d4 != finalcircle) {
            var_b0b91d4.origin = function_3e47f08b(var_b0b91d4);
        }
        level function_130c92ab(finalcircle);
        if (function_9bae34b3(var_b0b91d4, finalcircle)) {
            if (function_a0004b40(var_b0b91d4, finalindex)) {
                /#
                    iprintlnbold("<dev string:x168>" + attempts);
                    level.var_47947565[level.var_47947565.size] = finalcircle.tracepos;
                #/
                level flag::set(#"hash_43bac6444a9b65f3");
                return true;
            }
            /#
                level.var_475c53d7[level.var_475c53d7.size] = finalcircle.tracepos;
            #/
        }
        waitframe(1);
    }
    /#
        iprintlnbold("<dev string:x17e>" + attempts);
    #/
    level flag::set(#"hash_43bac6444a9b65f3");
    return true;
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0x8873da7e, Offset: 0x1648
// Size: 0x216
function private function_9bae34b3(var_b0b91d4, finalcircle) {
    maxdist = var_b0b91d4.radius - finalcircle.radius;
    maxdistsq = maxdist * maxdist;
    finalcircle.attempts = 0;
    while (finalcircle.attempts < 10) {
        finalcircle.attempts++;
        origin = function_3e47f08b(finalcircle);
        if (finalcircle != var_b0b91d4) {
            distsq = distance2dsquared(var_b0b91d4.origin, origin);
            if (distsq > maxdistsq) {
                /#
                    level.var_475c53d7[level.var_475c53d7.size] = origin;
                #/
                continue;
            }
        }
        trace = groundtrace(origin + (0, 0, 20000), origin + (0, 0, -10000), 0, undefined);
        tracepos = trace[#"position"];
        if (trace[#"fraction"] >= 1 || trace[#"surfacetype"] == #"water" || trace[#"surfacetype"] == #"watershallow" || !_second_compass_map_mp_ruins(origin)) {
            /#
                level.var_475c53d7[level.var_475c53d7.size] = tracepos;
            #/
            continue;
        }
        finalcircle.origin = origin;
        /#
            finalcircle.tracepos = tracepos;
        #/
        return true;
    }
    return false;
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0xfe59bd3d, Offset: 0x1868
// Size: 0x9e
function private function_a0004b40(var_b0b91d4, finalindex) {
    for (i = finalindex - 1; i > 0; i--) {
        circle = level.deathcircles[i];
        nextcircle = level.deathcircles[i + 1];
        if (!function_a84cfbd0(var_b0b91d4, circle, nextcircle)) {
            return false;
        }
    }
    return true;
}

// Namespace death_circle/death_circle
// Params 3, eflags: 0x4
// Checksum 0x6647157b, Offset: 0x1910
// Size: 0x332
function private function_a84cfbd0(var_b0b91d4, circle, nextcircle) {
    var_f811e54e = var_b0b91d4.radius - circle.radius;
    sqinterfaceattributes = var_f811e54e * var_f811e54e;
    var_897ef629 = circle.radius - nextcircle.radius;
    var_eccfdb0 = var_897ef629 * var_897ef629;
    pplate_pplatede = circle.radius * 0.01;
    var_e3cedc58 = pplate_pplatede * pplate_pplatede;
    circle.attempts = 0;
    while (circle.attempts < 10) {
        circle.attempts++;
        x = nextcircle.origin[0] + randomfloatrange(var_897ef629 * -1, var_897ef629);
        if (circle.mapwidth > 0) {
            halfwidth = circle.mapwidth / 2;
            if (x < circle.var_3b9f4abf[0] - halfwidth || x > circle.var_3b9f4abf[0] + halfwidth) {
                continue;
            }
        }
        y = nextcircle.origin[1] + randomfloatrange(var_897ef629 * -1, var_897ef629);
        if (circle.mapheight > 0) {
            halfheight = circle.mapheight / 2;
            if (y < circle.var_3b9f4abf[1] - halfheight || y > circle.var_3b9f4abf[1] + halfheight) {
                continue;
            }
        }
        origin = (x, y, 0);
        var_175e94e8 = distance2dsquared(var_b0b91d4.origin, origin);
        if (var_175e94e8 > sqinterfaceattributes) {
            continue;
        }
        var_6eb6c7b5 = distance2dsquared(nextcircle.origin, origin);
        if (var_6eb6c7b5 > var_eccfdb0 || var_6eb6c7b5 < var_e3cedc58) {
            continue;
        }
        if (!_second_compass_map_mp_ruins(origin)) {
            continue;
        }
        circle.origin = origin;
        /#
            trace = groundtrace(origin + (0, 0, 20000), origin + (0, 0, -10000), 0, undefined);
            circle.tracepos = trace[#"position"];
        #/
        return true;
    }
    return false;
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0xdb3418b7, Offset: 0x1c50
// Size: 0x108
function private function_3e47f08b(circle) {
    xoffset = 0;
    yoffset = 0;
    if (circle.mapwidth > 0) {
        halfwidth = circle.mapwidth / 2;
        xoffset = randomfloatrange(halfwidth * -1, halfwidth);
    }
    if (circle.mapheight > 0) {
        halfheight = circle.mapheight / 2;
        yoffset = randomfloatrange(halfheight * -1, halfheight);
    }
    origin = (circle.var_3b9f4abf[0] + xoffset, circle.var_3b9f4abf[1] + yoffset, circle.var_3b9f4abf[2]);
    return origin;
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x6f6138d2, Offset: 0x1d60
// Size: 0x8a
function private _second_compass_map_mp_ruins(origin) {
    if (isarray(level.var_f90fc07b)) {
        return function_bd00a301(origin, level.var_f90fc07b);
    } else if (isarray(level.oob_triggers)) {
        return !function_bd00a301(origin, level.oob_triggers);
    }
    return 1;
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0xf2623519, Offset: 0x1df8
// Size: 0xfa
function private function_bd00a301(origin, triggers) {
    foreach (trigger in triggers) {
        if (!isdefined(trigger) || !trigger istriggerenabled()) {
            continue;
        }
        testpos = (origin[0], origin[1], trigger.origin[2]);
        if (istouching(testpos, trigger)) {
            return true;
        }
    }
    return false;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0xbec524e6, Offset: 0x1f00
// Size: 0x2c
function function_55bf22ef() {
    waitframe(1);
    level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 1);
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x6029307a, Offset: 0x1f38
// Size: 0x5c
function function_b57e3cde(enabled) {
    if (enabled) {
        self flag::set(#"hash_3bd867e0639cb28e");
        return;
    }
    self flag::clear(#"hash_3bd867e0639cb28e");
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x447b0fe7, Offset: 0x1fa0
// Size: 0x22
function function_dca12a73() {
    return flag::get(#"hash_3bd867e0639cb28e");
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0xc267cbe5, Offset: 0x1fd0
// Size: 0x52
function private function_ccac34f8(var_36aa237c, var_11dc771d) {
    wait var_36aa237c;
    level clientfield::set_world_uimodel("hudItems.warzone.collapse", var_11dc771d);
    level.deathcircle.var_d60fd7cd = var_11dc771d;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0xdc13d576, Offset: 0x2030
// Size: 0xa4
function private function_a1dbce4a() {
    self notify("178864bb02cc31b7");
    self endon("178864bb02cc31b7");
    self endon(#"death");
    if (level flag::get(#"hash_60fcdd11812a0134")) {
        return;
    }
    self ghost();
    level flag::wait_till(#"hash_60fcdd11812a0134");
    self show();
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0xbf8e1bc8, Offset: 0x20e0
// Size: 0xabc
function start() {
    level endoncallback(&cleanup_circle, #"game_ended", #"hash_12a8f2c59a67e4fc");
    if (!level.deathcircle.enabled || level.deathcircles.size <= 0) {
        return;
    }
    /#
        function_ded40950();
    #/
    startindex = getdvarint(#"deathcircle_startindex", 0);
    var_7a6bf18a = level.deathcircles[startindex];
    delaysec = startindex < 0 ? level.deathcircle.delaysec : 0;
    if (level.var_f2814a96 === 0) {
        level flag::wait_till(#"insertion_teleport_completed");
    }
    level.deathcircle.var_d60fd7cd = gettime() + int((var_7a6bf18a.waitsec + delaysec) * 1000);
    level clientfield::set_world_uimodel("hudItems.warzone.collapse", level.deathcircle.var_d60fd7cd);
    wait delaysec;
    level.deathcircle.var_5c54ab33 = function_a8749d88(var_7a6bf18a.origin, var_7a6bf18a.radius, var_7a6bf18a.damage, var_7a6bf18a.damageinterval, var_7a6bf18a.var_18fa918d, var_7a6bf18a.var_55ad5e4, var_7a6bf18a.var_c3bf31b);
    level thread function_dc15ad60(level.deathcircle.var_5c54ab33);
    circle = undefined;
    var_9275bfa4 = undefined;
    level flag::set(#"hash_405e46788e83af41");
    level callback::callback(#"hash_405e46788e83af41");
    level.var_74887eb = level.deathcircles.size - 1;
    if (util::get_game_type() == #"warzone_bigteam_dbno_quad") {
        level.var_74887eb = level.deathcircles.size - 3;
    }
    level.var_245d4af9 = level.var_74887eb - 1;
    level clientfield::set_world_uimodel("hudItems.warzone.collapseCount", level.var_74887eb);
    level.var_78442886 = -1;
    for (i = startindex; i < level.deathcircles.size; i++) {
        if (i + 1 == level.deathcircles.size) {
            level callback::callback(#"hash_7119d854cd41a4fd");
        }
        level.deathcircleindex = i;
        level clientfield::set_world_uimodel("hudItems.warzone.collapseIndex", i);
        circle = level.deathcircles[i];
        nextcircle = level.deathcircles[i + 1];
        level.deathcircle.var_46fc3d6e = circle;
        level.deathcircle.nextcircle = nextcircle;
        if (isdefined(nextcircle)) {
            level notify(#"hash_1ff3496c9049969");
            var_7791d394 = nextcircle;
            if (is_true(getgametypesetting(#"hash_21ab1ca7e18bddcd"))) {
                var_87f4757a = isdefined(getgametypesetting(#"hash_3e62d9528eca0a13")) ? getgametypesetting(#"hash_3e62d9528eca0a13") : 0;
                if (1 && level.deathcircles.size > var_87f4757a && i + 1 < var_87f4757a) {
                    var_7791d394 = level.deathcircles[var_87f4757a];
                }
            }
            if (isdefined(level.var_bd19c3a8)) {
                [[ level.var_bd19c3a8 ]]();
            }
            if (!isdefined(var_9275bfa4)) {
                var_9275bfa4 = function_bfdaeb3a(var_7791d394.origin, var_7791d394.radius);
            } else {
                var_9275bfa4 dontinterpolate();
                var_9275bfa4.origin = var_7791d394.origin;
                function_55ffaf7(var_9275bfa4, var_7791d394.radius);
            }
            if (is_true(getgametypesetting(#"hash_21ab1ca7e18bddcd"))) {
                var_9275bfa4 thread function_a1dbce4a();
            }
        } else if (isdefined(var_9275bfa4)) {
            var_9275bfa4 delete();
        }
        if (!isdefined(nextcircle) && is_true(level.deathcircle.var_cb3d0e42)) {
            break;
        }
        if (circle.waitsec > 0) {
            setmatchflag("bomb_timer_a", 1);
            setbombtimer("A", gettime() + 1000 + int(circle.waitsec * 1000));
            level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", 0);
            waitframe(1);
            function_55bf22ef();
        }
        level countdown(circle.waitsec, i, nextcircle);
        setmatchflag("bomb_timer_a", 0);
        level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 2);
        level.deathcircle.var_5c54ab33.damage = circle.damage;
        level.deathcircle.var_5c54ab33.damageinterval = circle.damageinterval;
        level.deathcircle.var_5c54ab33.var_18fa918d = circle.var_18fa918d;
        level.deathcircle.var_5c54ab33.var_55ad5e4 = circle.var_55ad5e4;
        level.deathcircle.var_5c54ab33.var_c3bf31b = circle.var_c3bf31b;
        if (isdefined(nextcircle)) {
            level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", 0);
            level thread function_ccac34f8(1, gettime() + int((circle.scalesec + nextcircle.waitsec) * 1000));
        } else {
            setmatchflag("bomb_timer_b", 0);
        }
        level.var_78442886 = i;
        level callback::callback(#"hash_3057417db7f8acdd");
        if (isdefined(nextcircle)) {
            function_9229c3b3(level.deathcircle.var_5c54ab33, nextcircle.radius, nextcircle.origin, circle.scalesec);
        } else {
            function_9229c3b3(level.deathcircle.var_5c54ab33, 0, circle.origin, circle.scalesec);
        }
        level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 0);
        level callback::callback(#"hash_7912e21750e4010d");
        level flag::wait_till_clear(#"hash_59a3f6eb04b60db0");
    }
    if (is_true(level.deathcircle.var_672f2d98)) {
        var_904b645e = isdefined(level.deathcircle.var_672f2d98) ? level.deathcircle.var_672f2d98 : 0;
        if (var_904b645e > 0) {
            setmatchflag("bomb_timer_a", 1);
            setbombtimer("A", gettime() + 1000 + int(var_904b645e * 1000));
            function_55bf22ef();
            wait var_904b645e;
            setmatchflag("bomb_timer_a", 0);
            level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 0);
        }
        if (isdefined(level.ontimelimit)) {
            [[ level.ontimelimit ]]();
        }
    }
}

// Namespace death_circle/death_circle
// Params 7, eflags: 0x0
// Checksum 0x8d35ebe, Offset: 0x2ba8
// Size: 0x136
function function_a8749d88(origin, radius, damage, damageinterval, var_18fa918d = 0, var_55ad5e4 = 0, var_c3bf31b = 0) {
    deathcircle = spawn("script_model", origin);
    deathcircle.targetname = "death_circle";
    deathcircle setmodel("tag_origin");
    function_55ffaf7(deathcircle, radius);
    deathcircle clientfield::set("deathcircleflag", 1);
    deathcircle.damage = damage;
    deathcircle.damageinterval = damageinterval;
    deathcircle.var_18fa918d = var_18fa918d;
    deathcircle.var_55ad5e4 = var_55ad5e4;
    deathcircle.var_c3bf31b = var_c3bf31b;
    return deathcircle;
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x0
// Checksum 0xffdf1ee9, Offset: 0x2ce8
// Size: 0xb8
function function_bfdaeb3a(origin, radius) {
    nextcircle = spawn("script_model", origin);
    nextcircle.targetname = "next_death_circle";
    nextcircle setmodel("tag_origin");
    function_55ffaf7(nextcircle, radius);
    nextcircle.team = #"neutral";
    nextcircle clientfield::set("deathcircleflag", 1);
    return nextcircle;
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x0
// Checksum 0xe981e4ca, Offset: 0x2da8
// Size: 0x86
function function_55ffaf7(circle, radius) {
    if (radius > 0) {
        circle show();
        circle.radius = radius;
        circle setscale(radius / 15000);
        return;
    }
    circle hide();
    circle.radius = 0;
}

// Namespace death_circle/death_circle
// Params 3, eflags: 0x0
// Checksum 0xc3c78f07, Offset: 0x2e38
// Size: 0x26c
function function_190ab063(v_origin, n_radius, notify_end) {
    if (!isentity(level.deathcircle)) {
        return;
    }
    level flag::set(#"hash_18141f1491e42a85");
    level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 0);
    var_17eeb662 = level.deathcircle.origin;
    var_24d6686a = level.deathcircle.radius;
    if (!is_true(level.deathcircle.scaling)) {
        var_e9f455c0 = level.deathcircles[level.deathcircleindex].waitsec;
        setmatchflag("bomb_timer_a", 0);
    }
    level.deathcircle.origin = v_origin;
    function_55ffaf7(level.deathcircle, n_radius);
    level waittill(notify_end);
    function_55ffaf7(level.deathcircle, var_24d6686a);
    level.deathcircle.origin = var_17eeb662;
    if (isdefined(var_e9f455c0) && var_e9f455c0 > 0) {
        setbombtimer("A", gettime() + 1000 + int(var_e9f455c0 * 1000));
        setmatchflag("bomb_timer_a", 1);
        waitframe(1);
        level thread function_55bf22ef();
    } else {
        level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 2);
    }
    level flag::clear(#"hash_18141f1491e42a85");
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x347fd5f3, Offset: 0x30b0
// Size: 0xb4
function function_98cf45ae() {
    if (!level.deathcircle.enabled) {
        return;
    }
    level flag::set(#"hash_18141f1491e42a85");
    level.deathcircle.var_5c54ab33 moveto(level.deathcircle.var_5c54ab33.origin, 0.1);
    level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 0);
    setmatchflag("bomb_timer_a", 0);
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x9417a7d3, Offset: 0x3170
// Size: 0x164
function function_d61ba114(var_9c038d31 = 0) {
    if (!level.deathcircle.enabled) {
        return;
    }
    if (!is_true(level.deathcircle.var_5c54ab33.scaling)) {
        var_4863283f = level.deathcircles[level.deathcircleindex].waitsec;
    }
    level flag::clear(#"hash_18141f1491e42a85");
    if (isdefined(var_4863283f) && var_9c038d31) {
        setbombtimer("A", gettime() + 1000 + int(var_4863283f * 1000));
        setmatchflag("bomb_timer_a", 1);
        waitframe(1);
        level thread function_55bf22ef();
    } else {
        level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 2);
    }
    wait 1.5;
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x2f470ad0, Offset: 0x32e0
// Size: 0x2c
function private cleanup_circle(*notifyhash) {
    level clientfield::set_world_uimodel("hudItems.warzone.collapseTimerState", 0);
}

// Namespace death_circle/death_circle
// Params 3, eflags: 0x4
// Checksum 0x3101baba, Offset: 0x3318
// Size: 0x1dc
function private countdown(waitsec, circleindex, nextcircle) {
    level endon(#"hash_3a3e3a27bf34fa8a");
    if (!isdefined(nextcircle)) {
        callback::callback(#"hash_3ab90c4405f67276");
    } else if (circleindex == 0) {
        callback::callback(#"hash_7ec09c8f8151205c");
    } else {
        callback::callback(#"hash_77fdc4459f2f1e35");
    }
    if (getdvarstring(#"g_gametype") === "survival" || getdvarstring(#"g_gametype") === "zsurvival") {
        function_2b2fc512(waitsec, 15);
    } else if (waitsec > 15 && waitsec >= 45) {
        wait waitsec - 15;
        callback::callback(#"hash_3cadee0b88ef66a2");
        wait 15;
    } else {
        wait waitsec;
    }
    callback::callback(#"hash_166e273d927bf6a3");
    playsoundatposition(#"hash_3fb30e7a85b2bf7e", (0, 0, 0));
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x0
// Checksum 0xde38cf0f, Offset: 0x3500
// Size: 0x118
function function_2b2fc512(waitsec, var_b96c8a8f) {
    if (waitsec > var_b96c8a8f && waitsec >= 45) {
        n_time = 0;
        while (n_time < waitsec - var_b96c8a8f) {
            wait 1;
            n_time++;
            level flag::wait_till_clear(#"hash_18141f1491e42a85");
        }
        callback::callback(#"hash_3cadee0b88ef66a2");
        n_time = 0;
        while (n_time < var_b96c8a8f) {
            wait 1;
            n_time++;
            level flag::wait_till_clear(#"hash_18141f1491e42a85");
        }
        return;
    }
    n_time = 0;
    while (n_time < waitsec) {
        wait 1;
        n_time++;
        level flag::wait_till_clear(#"hash_18141f1491e42a85");
    }
}

// Namespace death_circle/death_circle
// Params 4, eflags: 0x0
// Checksum 0x91454a31, Offset: 0x3620
// Size: 0x316
function function_9229c3b3(circle, newradius, neworigin, scalesec = 0) {
    level endon(#"game_ended", #"hash_12a8f2c59a67e4fc", #"hash_6adadb0779eac3c6");
    circle endon(#"hash_62db096da271699d");
    if (scalesec <= 0) {
        function_55ffaf7(circle, newradius);
        circle.origin = neworigin;
        return;
    }
    circle.scaling = 1;
    time = gettime();
    endtime = time + int(scalesec * 1000);
    level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", 0);
    circle moveto(neworigin, scalesec);
    scaledelta = newradius - circle.radius;
    frames = scalesec / float(function_60d95f53()) / 1000;
    framedelta = scaledelta / frames;
    progress = 0;
    var_6e09d4b7 = 1 / frames;
    while (time < endtime) {
        if (level flag::get(#"hash_18141f1491e42a85")) {
            pausetime = gettime();
            level flag::wait_till_clear(#"hash_18141f1491e42a85");
            var_9bd64c7b = gettime();
            endtime += var_9bd64c7b - pausetime;
            circle moveto(neworigin, float(endtime - var_9bd64c7b) / 1000);
        }
        function_55ffaf7(circle, circle.radius + framedelta);
        if (circle.radius <= 0) {
            break;
        }
        progress += var_6e09d4b7;
        level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", progress);
        waitframe(1);
        time = gettime();
    }
    level clientfield::set_world_uimodel("hudItems.warzone.collapseProgress", 1);
    circle.scaling = 0;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0xb91cf4e1, Offset: 0x3940
// Size: 0x52
function private function_8bd303cc() {
    player = self;
    if (isdefined(player) && !is_true(player.outsidedeathcircle)) {
        player.outsidedeathcircle = 1;
        player.var_1f1736dc = gettime();
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0xebe60c3c, Offset: 0x39a0
// Size: 0xc4
function private function_ce0f27e0() {
    player = self;
    if (isdefined(player) && is_true(player.outsidedeathcircle)) {
        player.outsidedeathcircle = 0;
        if (isdefined(player.var_1f1736dc)) {
            var_7dbb0472 = int(gettime() - player.var_1f1736dc);
            player stats::function_d40764f3(#"hash_44caad08afb32e51", var_7dbb0472);
            player match_record::function_34800eec(#"hash_3e8d4387ea9e7f42", var_7dbb0472);
        }
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x4745f52b, Offset: 0x3a70
// Size: 0xa6
function function_a086017a(point) {
    if (!is_active()) {
        return true;
    }
    distsq = distance2dsquared(point, level.deathcircle.var_5c54ab33.origin);
    radiussq = sqr(level.deathcircle.var_5c54ab33.radius);
    if (distsq > radiussq) {
        return false;
    }
    return true;
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x315a8705, Offset: 0x3b20
// Size: 0x706
function function_dc15ad60(deathcircle) {
    level endoncallback(&cleanup_feedback, #"game_ended", #"hash_12a8f2c59a67e4fc");
    var_f4d9a132 = gettime() + int(deathcircle.damageinterval * 1000);
    updatepass = 0;
    while (isdefined(deathcircle)) {
        radiussq = deathcircle.radius * deathcircle.radius;
        origin = deathcircle.origin;
        dodamage = gettime() >= var_f4d9a132;
        level.deathcircle.players = [];
        time = gettime();
        foreach (i, player in getplayers()) {
            if (is_true(deathcircle.scaling) && i % 5 == updatepass) {
                player function_ba02cfb5();
            }
            if (!isalive(player)) {
                player function_60d14da8(0);
                player clientfield::set("outsidedeathcircle", 0);
                player hide_effects();
                player function_ce0f27e0();
                continue;
            }
            distsq = distance2dsquared(player.origin, origin);
            if (distsq >= radiussq && !player function_dca12a73()) {
                level.deathcircle.players[level.deathcircle.players.size] = player;
                if (!isdefined(player.var_b8328141)) {
                    player.var_b8328141 = time + deathcircle.var_55ad5e4;
                }
                damage = deathcircle.damage;
                if (!isdefined(player.var_6cd69660)) {
                    player.var_6cd69660 = 0;
                }
                if (player.var_6cd69660 == 0 && time + deathcircle.var_55ad5e4 < player.var_b8328141) {
                    player.var_b8328141 = time + deathcircle.var_55ad5e4;
                } else if (player.var_6cd69660 != 0 && time + deathcircle.var_c3bf31b < player.var_b8328141) {
                    player.var_b8328141 = time + deathcircle.var_c3bf31b;
                }
                if (time >= player.var_b8328141) {
                    player.var_6cd69660 += deathcircle.var_18fa918d;
                    player.var_b8328141 = time + deathcircle.var_c3bf31b;
                }
                player.deathcircledamage = damage + player.var_6cd69660;
                if (isdefined(level.deathcircle.var_5c54ab33.intensity)) {
                    intensity = level.deathcircle.var_5c54ab33.intensity;
                } else if (isdefined(level.var_ab9cd581) && player.deathcircledamage >= level.var_ab9cd581) {
                    intensity = 3;
                } else if (isdefined(level.var_6c870a00) && player.deathcircledamage >= level.var_6c870a00) {
                    intensity = 2;
                } else {
                    intensity = 1;
                }
                player function_60d14da8(1);
                player clientfield::set("outsidedeathcircle", 1);
                player show_effects(intensity);
                player function_8bd303cc();
                if (dodamage) {
                    damage = player.deathcircledamage;
                    if (player hasperk(#"specialty_outlander")) {
                        damage = int(ceil(damage * 0.5));
                    }
                    player dodamage(damage, origin, deathcircle, undefined, undefined, "MOD_DEATH_CIRCLE");
                    player stats::function_d40764f3(#"hash_3498c2a577aa328e", int(damage));
                    player match_record::function_34800eec(#"hash_3498c2a577aa328e", int(damage));
                }
                continue;
            }
            player function_60d14da8(0);
            player clientfield::set("outsidedeathcircle", 0);
            player hide_effects();
            player function_ce0f27e0();
            player.var_6cd69660 = 0;
            player.var_b8328141 = time + deathcircle.var_55ad5e4;
        }
        if (dodamage) {
            var_f4d9a132 = gettime() + int(deathcircle.damageinterval * 1000);
        }
        updatepass = (updatepass + 1) % 5;
        waitframe(1);
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x3912183a, Offset: 0x4230
// Size: 0xb0
function private cleanup_feedback(*notifyhash) {
    foreach (player in getplayers()) {
        player function_60d14da8(0);
        player hide_effects();
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x5481b77e, Offset: 0x42e8
// Size: 0x36c
function function_ba02cfb5() {
    var_46fc3d6e = level.deathcircle.var_46fc3d6e;
    nextcircle = level.deathcircle.nextcircle;
    if (!(isdefined(var_46fc3d6e) && isdefined(nextcircle))) {
        return;
    }
    playerorigin = self function_664f77db();
    if (isdefined(nextcircle) && distance2dsquared(playerorigin, nextcircle.origin) <= nextcircle.radiussq) {
        self clientfield::set_player_uimodel("hudItems.distanceFromDeathCircle", 1);
        return;
    }
    if (distance2dsquared(playerorigin, var_46fc3d6e.origin) >= var_46fc3d6e.radiussq) {
        self clientfield::set_player_uimodel("hudItems.distanceFromDeathCircle", 0);
        return;
    }
    nextcenter = isdefined(nextcircle) ? nextcircle.origin : var_46fc3d6e.origin;
    dir = vectornormalize(playerorigin - nextcenter);
    nextpoint = nextcenter;
    if (isdefined(nextcircle)) {
        nextpoint = nextcenter + dir * nextcircle.radius;
    }
    prevpoint = function_936b3f09(nextcenter, dir, var_46fc3d6e);
    totaldist = distance2d(prevpoint, nextpoint);
    playerdist = distance2d(prevpoint, playerorigin);
    self clientfield::set_player_uimodel("hudItems.distanceFromDeathCircle", playerdist / totaldist);
    /#
        if (self ishost() && getdvarint(#"deathcircle_debug", 0)) {
            radius = 150;
            sphere(nextpoint, radius, (0, 1, 0), 1, 0, 10, 5);
            line(playerorigin, nextpoint, (0, 1, 0), 1, 0, 5);
            sphere(prevpoint, radius, (1, 0, 0), 1, 0, 10, 5);
            line(playerorigin, prevpoint, (1, 0, 0), 1, 0, 5);
            deathpoint = function_936b3f09(nextcenter, dir, level.deathcircle.var_5c54ab33);
            sphere(deathpoint, 125, (1, 0, 1), 1, 0, 10, 5);
        }
    #/
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0xf8e9bad3, Offset: 0x4660
// Size: 0xf6
function function_664f77db() {
    if (self.spectatorclient != -1) {
        player = getentbynum(self.spectatorclient);
        if (isplayer(player)) {
            return (player.origin[0], player.origin[1], 0);
        }
    } else if (self.currentspectatingclient != -1) {
        player = getentbynum(self.currentspectatingclient);
        if (isplayer(player)) {
            return (player.origin[0], player.origin[1], 0);
        }
    }
    return (self.origin[0], self.origin[1], 0);
}

// Namespace death_circle/death_circle
// Params 3, eflags: 0x0
// Checksum 0x7f8a34a3, Offset: 0x4760
// Size: 0xdc
function function_936b3f09(p, d, circle) {
    m = p - circle.origin;
    b = vectordot(m, d);
    c = vectordot(m, m) - circle.radius * circle.radius;
    discr = b * b - c;
    t = b * -1 + sqrt(discr);
    return p + t * d;
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x26c67dc9, Offset: 0x4848
// Size: 0x2c
function show_effects(intensity) {
    self clientfield::set_to_player("deathcircleeffects", intensity);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x14b71d4d, Offset: 0x4880
// Size: 0x24
function hide_effects() {
    self clientfield::set_to_player("deathcircleeffects", 0);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x2f46ce95, Offset: 0x48b0
// Size: 0x420
function function_27d5d349() {
    if (!is_active()) {
        return;
    }
    for (i = 0; i < level.deathcircles.size; i++) {
        assert(i < 14, "<dev string:x198>");
        circle = level.deathcircles[i];
        match_record::function_7a93acec(#"death_circle", i, #"origin", circle.origin);
        match_record::set_stat(#"death_circle", i, #"radius", int(circle.radius));
        match_record::set_stat(#"death_circle", i, #"damage", int(circle.damage));
        match_record::set_stat(#"death_circle", i, #"damage_interval", circle.damageinterval);
        match_record::set_stat(#"death_circle", i, #"wait_sec", circle.waitsec);
        match_record::set_stat(#"death_circle", i, #"scale_sec", circle.scalesec);
        match_record::set_stat(#"death_circle", i, #"final", 0);
        if (i == level.deathcircleindex) {
            i++;
            match_record::function_7a93acec(#"death_circle", i, #"origin", level.deathcircle.var_5c54ab33.origin);
            match_record::set_stat(#"death_circle", i, #"radius", level.deathcircle.var_5c54ab33.radius);
            match_record::set_stat(#"death_circle", i, #"damage", level.deathcircle.var_5c54ab33.damage);
            match_record::set_stat(#"death_circle", i, #"damage_interval", level.deathcircle.var_5c54ab33.damageinterval);
            match_record::set_stat(#"death_circle", i, #"wait_sec", circle.waitsec);
            match_record::set_stat(#"death_circle", i, #"scale_sec", circle.scalesec);
            match_record::set_stat(#"death_circle", i, #"final", 1);
            break;
        }
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x23592149, Offset: 0x4cd8
// Size: 0x76
function function_49443399() {
    time = 0;
    for (i = 0; i < level.deathcircles.size - 1; i++) {
        time += level.deathcircles[i].scalesec + level.deathcircles[i].waitsec;
    }
    return time;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x3760dd21, Offset: 0x4d58
// Size: 0x3a
function function_9956f107() {
    if (!is_active() || isdefined(level.deathcircle.nextcircle)) {
        return false;
    }
    return true;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x6ea7df0, Offset: 0x4da0
// Size: 0xea
function function_d66a3de1() {
    if (is_true(level.spawnsystem.deathcirclerespawn)) {
        var_3db6ed91 = level.deathcircles.size - 2;
        if (var_3db6ed91 < 0) {
            var_3db6ed91 = 0;
        }
        if (is_true(level.spawnsystem.deathcirclerespawn) && (isdefined(level.var_78442886) ? level.var_78442886 : 0) >= var_3db6ed91) {
            return false;
        }
        if (isdefined(level.var_78442886) && isdefined(level.var_245d4af9) && level.var_78442886 >= level.var_245d4af9) {
            return false;
        }
        return true;
    }
    return false;
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x1c938a89, Offset: 0x4e98
// Size: 0x78
function function_4dc40125() {
    if (is_true(level.spawnsystem.deathcirclerespawn) && function_9956f107()) {
        return (function_b1565133() || level.deathcircle.var_5c54ab33.radius <= 0);
    }
    return false;
}

/#

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0xad564326, Offset: 0x4f18
    // Size: 0x436
    function private devgui_loop() {
        level endon(#"game_ended");
        while (!canadddebugcommand()) {
            waitframe(1);
        }
        adddebugcommand("<dev string:x1d2>");
        adddebugcommand("<dev string:x1f6>");
        adddebugcommand("<dev string:x223>");
        adddebugcommand("<dev string:x252>");
        adddebugcommand("<dev string:x281>");
        adddebugcommand("<dev string:x2af>" + 150000);
        adddebugcommand("<dev string:x2d1>");
        if (getdvarint(#"testcircleradius", 0) > 0) {
            adddebugcommand("<dev string:x2f7>");
            adddebugcommand("<dev string:x343>");
        }
        adddebugcommand("<dev string:x395>");
        adddebugcommand("<dev string:x3de>");
        adddebugcommand("<dev string:x420>");
        adddebugcommand("<dev string:x47c>");
        adddebugcommand("<dev string:x4d7>");
        var_52a6b3a = struct::get_array(#"hash_39f96305bd3fed10", "<dev string:x539>");
        foreach (area in var_52a6b3a) {
            adddebugcommand("<dev string:x548>" + area.targetname + "<dev string:x578>" + area.targetname + "<dev string:x5a8>");
        }
        adddebugcommand("<dev string:x5ad>");
        adddebugcommand("<dev string:x5fa>");
        adddebugcommand("<dev string:x651>");
        while (true) {
            wait 0.25;
            dvarstr = getdvarstring(#"devgui_deathcircle", "<dev string:x69a>");
            if (dvarstr == "<dev string:x69a>") {
                continue;
            }
            setdvar(#"devgui_deathcircle", "<dev string:x69a>");
            args = strtok(dvarstr, "<dev string:x69e>");
            switch (args[0]) {
            case #"clear":
                devgui_clear();
                break;
            case #"shuffle":
                level thread devgui_shuffle(args[1]);
                break;
            case #"hash_5d7130ece48ceb02":
                level thread function_e4f60619(args[1]);
                break;
            }
        }
    }

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0x1c349a5f, Offset: 0x5358
    // Size: 0x5c
    function private devgui_clear() {
        level notify(#"hash_12a8f2c59a67e4fc");
        if (isdefined(level.deathcircle.var_5c54ab33)) {
            level.deathcircle.var_5c54ab33 delete();
        }
    }

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0x69d6c85b, Offset: 0x53c0
    // Size: 0x9a2
    function private debug_loop() {
        level endon(#"game_ended");
        while (true) {
            host = util::gethostplayer();
            if (!isplayer(host)) {
                waitframe(1);
                continue;
            }
            if (getdvarint(#"deathcircle_debug", 0)) {
                debugindex = getdvarint(#"hash_31a5138991bbbf63", -1);
                var_a15ea324 = getdvarint(#"hash_118a6d37e5aa4589", 0);
                maxindex = level.deathcircles.size - 1;
                if (debugindex >= 0) {
                    circle = level.deathcircles[debugindex];
                    if (isdefined(circle)) {
                        color = circle_color(debugindex, maxindex);
                        draw_circle(circle, debugindex, color, var_a15ea324);
                    }
                } else {
                    index = 0;
                    foreach (circle in level.deathcircles) {
                        color = circle_color(index, maxindex);
                        draw_circle(circle, index, color, var_a15ea324);
                        index++;
                    }
                }
                minimaporigins = getentarray("<dev string:x6a3>", "<dev string:x6b5>");
                foreach (corner in minimaporigins) {
                    origin = corner.origin;
                    origin2d = (origin[0], origin[1], 0);
                    var_c3685153 = function_507ec82a(host, origin, 500);
                    sphere(origin, 16 * var_c3685153, (0, 1, 1));
                    print3d(origin, "<dev string:x6a3>", (1, 1, 1), 1, var_c3685153, 1, 1);
                    line(origin2d + (0, 0, 20000), origin2d + (0, 0, -10000), (0, 1, 1));
                }
                foreach (center in level.var_47947565) {
                    line(center, center + (0, 0, 500), (1, 0, 1));
                }
                foreach (origin in level.var_475c53d7) {
                    line(origin, origin + (0, 0, 10000), (1, 0, 0));
                }
            }
            if (getdvarint(#"hash_4c1be22e9ad0498b", 1)) {
                dir = host getplayerangles();
                fwd = anglestoforward(dir);
                var_98b02a87 = host getplayerviewheight();
                eye = host.origin + (0, 0, var_98b02a87);
                end = eye + fwd * 10000;
                trace = groundtrace(eye, end, 0, host);
                if (trace[#"fraction"] < 1) {
                    var_95341914 = (0, 1, 0);
                    label = trace[#"surfacetype"];
                    switch (label) {
                    case #"water":
                    case #"watershallow":
                        var_95341914 = (1, 0, 0);
                        break;
                    }
                    pos = trace[#"position"];
                    textscale = function_507ec82a(host, pos, 750);
                    line(pos, pos + (0, 0, 5000), var_95341914);
                    print3d(pos + (0, 0, 8), label, (1, 1, 1), 1, textscale, 1, 1);
                }
            }
            if (getdvarint(#"hash_4ad1e4d0877ddaa3", 0)) {
                var_52a6b3a = struct::get_array(#"hash_39f96305bd3fed10", "<dev string:x539>");
                foreach (area in var_52a6b3a) {
                    halfwidth = area.width / 2;
                    halfheight = area.height / 2;
                    var_b99d691b = area.origin + (halfwidth, halfheight, 0);
                    var_91d25b4a = area.origin + (halfwidth, halfheight * -1, 0);
                    var_3c4ec32 = area.origin + (halfwidth * -1, halfheight * -1, 0);
                    var_55e2210d = area.origin + (halfwidth * -1, halfheight, 0);
                    textscale = function_507ec82a(host, area.origin, 500);
                    print3d(area.origin, area.targetname, (1, 1, 1), 1, textscale, 1, 1);
                    color = is_true(getdvarint(area.targetname, 0)) ? (1, 0, 1) : (0, 0, 1);
                    line(var_b99d691b, var_91d25b4a, color);
                    line(var_91d25b4a, var_3c4ec32, color);
                    line(var_3c4ec32, var_55e2210d, color);
                    line(var_55e2210d, var_b99d691b, color);
                }
            }
            waitframe(1);
        }
    }

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0x4701f91a, Offset: 0x5d70
    // Size: 0x294
    function private function_ded40950() {
        testcircleradius = getdvarint(#"testcircleradius", 0);
        if (testcircleradius < 0) {
            testcircleradius = 0;
        } else if (testcircleradius > 150000) {
            testcircleradius = 150000;
        }
        if (testcircleradius > 0) {
            level.deathcircles = [];
            level.deathcircle.delaysec = 0;
            centerstr = getdvarstring(#"hash_76b26d6e696b82e8", "<dev string:x69a>");
            damage = getdvarint(#"testcircledamage", 0);
            damageinterval = getdvarint(#"hash_700ae39acbcd84e5", 60);
            waitsec = getdvarint(#"hash_5779bb38cf5f61a9", 36000);
            scalesec = getdvarint(#"hash_537f05a2ad3b9d7a", 60);
            intensity = getdvarint(#"hash_16271dbe4d00b41e", 1);
            center = (level.mapcenter[0], level.mapcenter[1], 0);
            if (centerstr != "<dev string:x69a>") {
                var_ad7b95c0 = strtok(centerstr, "<dev string:x6c3>");
                center = (float(var_ad7b95c0[0]), float(var_ad7b95c0[1]), 0);
            }
            add_circle(center, 0, 0, testcircleradius, damage, damageinterval, waitsec, scalesec, intensity);
            level thread function_81ccccb6();
        }
    }

    // Namespace death_circle/death_circle
    // Params 0, eflags: 0x4
    // Checksum 0xecebab1, Offset: 0x6010
    // Size: 0x16c
    function private function_81ccccb6() {
        level endon(#"game_ended");
        waitframe(1);
        while (isdefined(level.deathcircle.var_5c54ab33)) {
            radius = getdvarint(#"testcircleradius", 0);
            intensity = getdvarint(#"hash_16271dbe4d00b41e", 0);
            if (radius < 1) {
                radius = 1;
            } else if (radius > 150000) {
                radius = 150000;
            }
            if (!is_true(level.deathcircle.var_5c54ab33.scaling)) {
                level.deathcircle.var_5c54ab33.radius = radius;
                level.deathcircle.var_5c54ab33 setscale(radius / 15000);
            }
            level.deathcircle.var_5c54ab33.intensity = intensity;
            waitframe(1);
        }
    }

    // Namespace death_circle/death_circle
    // Params 1, eflags: 0x4
    // Checksum 0x395967f, Offset: 0x6188
    // Size: 0xf4
    function private devgui_shuffle(count) {
        if (!isdefined(count)) {
            count = 1;
        }
        devgui_clear();
        count = int(count);
        level.var_47947565 = [];
        level.var_475c53d7 = [];
        if (count > 1) {
            for (i = 0; i < count; i++) {
                shuffle_circles();
                waitframe(1);
            }
            return;
        }
        shuffle_circles();
        level.var_47947565[0] = level.deathcircles[level.deathcircles.size - 1].tracepos;
    }

    // Namespace death_circle/death_circle
    // Params 1, eflags: 0x4
    // Checksum 0xcc9331ee, Offset: 0x6288
    // Size: 0x9c
    function private function_e4f60619(var_f0ca5be1) {
        enabled = getdvarint(var_f0ca5be1, 0);
        if (is_true(enabled)) {
            setdvar(var_f0ca5be1, 0);
        } else {
            setdvar(var_f0ca5be1, 1);
        }
        level shuffle_circles();
    }

    // Namespace death_circle/death_circle
    // Params 1, eflags: 0x4
    // Checksum 0xbaae7716, Offset: 0x6330
    // Size: 0x29a
    function private simulate(var_1baf9723) {
        sim_count = 1000;
        var_9a165bb5 = 100;
        assert(var_1baf9723);
        var_f3ca456b = [];
        for (i = 0; i < sim_count; i++) {
            devgui_shuffle();
            for (c = 0; c < level.deathcircles.size; c++) {
                circle = {#origin_x:level.deathcircles[c].origin[0], #origin_y:level.deathcircles[c].origin[1], #radius:level.deathcircles[c].radius, #index:c};
                if (!isdefined(var_f3ca456b)) {
                    var_f3ca456b = [];
                } else if (!isarray(var_f3ca456b)) {
                    var_f3ca456b = array(var_f3ca456b);
                }
                var_f3ca456b[var_f3ca456b.size] = circle;
            }
            if (var_f3ca456b.size + level.deathcircles.size >= var_9a165bb5) {
                var_de130ab9 = {#var_91393a2d:var_1baf9723};
                function_92d1707f(#"hash_3a9b483e717d26be", #"info", var_de130ab9, #"circles", var_f3ca456b);
                wait 1;
                var_f3ca456b = [];
            }
        }
        if (var_f3ca456b.size >= 0) {
            var_de130ab9 = {#var_91393a2d:var_1baf9723};
            function_92d1707f(#"hash_3a9b483e717d26be", #"info", var_de130ab9, #"circles", var_f3ca456b);
            wait 1;
        }
    }

    // Namespace death_circle/death_circle
    // Params 4, eflags: 0x4
    // Checksum 0xca2f8b19, Offset: 0x65d8
    // Size: 0x3ac
    function private draw_circle(circle, index, color, groundtrace) {
        origin = groundtrace ? isdefined(circle.tracepos) ? circle.tracepos : circle.origin : circle.origin;
        printorigin = origin + (0, 0, 2000);
        var_6970fc75 = string(index);
        var_6970fc75 += "<dev string:x6c8>" + (isdefined(circle.attempts) ? circle.attempts : "<dev string:x6d7>");
        var_6970fc75 += "<dev string:x6dc>" + circle.radius;
        var_6970fc75 += "<dev string:x6e9>" + circle.damage;
        var_6970fc75 += "<dev string:x6f6>" + circle.damageinterval;
        var_6970fc75 += "<dev string:x70c>" + (isdefined(circle.waitsec) ? circle.waitsec : "<dev string:x6d7>");
        var_6970fc75 += "<dev string:x71b>" + (isdefined(circle.scalesec) ? circle.scalesec : "<dev string:x6d7>");
        print3d(printorigin, var_6970fc75, (1, 1, 1), 1, 5);
        line(printorigin, origin, color);
        sphere(origin, 5, color);
        circle(origin, circle.radius, color, 0, 1);
        if (isdefined(circle.var_3b9f4abf) && isdefined(circle.mapwidth) && isdefined(circle.mapheight)) {
            var_3b9f4abf = (circle.var_3b9f4abf[0], circle.var_3b9f4abf[1], origin[2]);
            halfwidth = circle.mapwidth / 2;
            halfheight = circle.mapheight / 2;
            var_b99d691b = var_3b9f4abf + (halfwidth, halfheight, 0);
            var_91d25b4a = var_3b9f4abf + (halfwidth, halfheight * -1, 0);
            var_3c4ec32 = var_3b9f4abf + (halfwidth * -1, halfheight * -1, 0);
            var_55e2210d = var_3b9f4abf + (halfwidth * -1, halfheight, 0);
            line(var_b99d691b, var_91d25b4a, (1, 0, 1));
            line(var_91d25b4a, var_3c4ec32, (1, 0, 1));
            line(var_3c4ec32, var_55e2210d, (1, 0, 1));
            line(var_55e2210d, var_b99d691b, (1, 0, 1));
        }
    }

    // Namespace death_circle/death_circle
    // Params 2, eflags: 0x0
    // Checksum 0xa729e7bf, Offset: 0x6990
    // Size: 0x114
    function circle_color(circleindex, maxindex) {
        colorscale = array((0, 1, 0), (1, 0.5, 0), (1, 1, 0), (1, 0, 0));
        if (circleindex >= maxindex) {
            return colorscale[colorscale.size - 1];
        } else if (circleindex <= 0) {
            return colorscale[0];
        }
        var_30de3274 = circleindex * colorscale.size / maxindex;
        var_30de3274 -= 1;
        colorindex = int(var_30de3274);
        colorfrac = var_30de3274 - colorindex;
        utilitycolor = vectorlerp(colorscale[colorindex], colorscale[colorindex + 1], colorfrac);
        return utilitycolor;
    }

    // Namespace death_circle/death_circle
    // Params 4, eflags: 0x0
    // Checksum 0x5ee9e407, Offset: 0x6ab0
    // Size: 0x7c
    function function_507ec82a(host, origin, mindist, defaultscale) {
        if (!isdefined(defaultscale)) {
            defaultscale = 1;
        }
        dist = distance(host.origin, origin);
        if (dist <= mindist) {
            return defaultscale;
        }
        return defaultscale * dist / mindist;
    }

#/
