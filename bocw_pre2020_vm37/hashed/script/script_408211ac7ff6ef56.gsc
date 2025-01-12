#using scripts\core_common\array_shared;

#namespace namespace_b637a3ed;

// Namespace namespace_b637a3ed/namespace_b637a3ed
// Params 5, eflags: 0x0
// Checksum 0x870da052, Offset: 0x68
// Size: 0xe4
function drop_items(items, origin, angles, var_7dc29c5a, random_yaw = 1) {
    index = 0;
    foreach (item in items) {
        if (!isdefined(item)) {
            continue;
        }
        item drop_item(index, origin, angles, var_7dc29c5a, random_yaw);
        index++;
    }
}

// Namespace namespace_b637a3ed/namespace_b637a3ed
// Params 5, eflags: 0x1 linked
// Checksum 0xa6d7f23b, Offset: 0x158
// Size: 0x1b4
function drop_item(index, origin, angles, var_98c867cd, random_yaw = 1) {
    min_angle = 0;
    max_angle = 360;
    height = 0;
    var_66694b96 = self function_c781b85c(index, origin, angles, var_98c867cd);
    self.origin = var_66694b96.start_origin;
    self.angles = var_66694b96.start_angles;
    if (random_yaw) {
        yaw = randomint(360);
        self.angles = (var_66694b96.start_angles[0], angleclamp180(var_66694b96.start_angles[1] + yaw), var_66694b96.start_angles[2]);
    }
    time = self function_3579cbe7(var_66694b96.start_origin, var_66694b96.start_angles, var_66694b96.end_origin, var_66694b96.end_angles);
    /#
        var_ad49c795 = getdvarint(#"hash_730e73fdf6a44e00", 0);
        if (var_ad49c795) {
            self thread function_f6480a82(time);
        }
    #/
}

// Namespace namespace_b637a3ed/namespace_b637a3ed
// Params 4, eflags: 0x1 linked
// Checksum 0x7c82ada2, Offset: 0x318
// Size: 0x194
function function_c781b85c(index, origin, angles, var_98c867cd) {
    ignore_entity = isentity(self) ? self : undefined;
    if (var_98c867cd == 3) {
        if (index % 2 > 0) {
            yaw = -25;
        } else {
            yaw = 25;
        }
        yaw += randomfloatrange(-10, 10);
        dist = 35 + index / 2 * 25 + randomfloatrange(-5, 5);
        return function_9345a4f7(index, origin, angles, undefined, yaw, dist);
    }
    if (var_98c867cd == 2) {
        return function_9345a4f7(index, origin, angles, ignore_entity);
    }
    if (var_98c867cd == 4) {
        return function_fb72164f(index, origin, angles, ignore_entity);
    }
    assert(0);
}

// Namespace namespace_b637a3ed/namespace_b637a3ed
// Params 6, eflags: 0x1 linked
// Checksum 0x7b2ac2b1, Offset: 0x4b8
// Size: 0x704
function function_9345a4f7(index, baseorigin, baseangles, ignoreent, var_8c967549, var_a17c7804) {
    assert(!isdefined(ignoreent) || isentity(ignoreent));
    var_13406a7f = 1;
    var_ad49c795 = getdvarint(#"hash_730e73fdf6a44e00", 0);
    var_5b5e9cdb = 13;
    var_a9c62ebc = 50;
    var_7e266d2a = 40;
    var_b5b1872d = -5;
    var_c2fd0740 = 5;
    var_f4c981a5 = 10;
    var_54ba6233 = 360 / var_5b5e9cdb;
    var_45875de2 = -5;
    var_af26a7db = 5;
    var_d0a44618 = 20;
    var_172c8bf4 = 60;
    var_f3e8e50d = -6;
    var_7def9f0 = 16;
    var_3512e170 = -18;
    var_5d9d83c2 = 0;
    ring = int(index / var_5b5e9cdb);
    slot = index - ring * var_5b5e9cdb;
    yaw = baseangles[1] + slot * var_54ba6233 + ring * var_f4c981a5 + randomfloatrange(var_45875de2, var_af26a7db);
    dist = var_a9c62ebc + ring * var_7e266d2a + randomfloatrange(var_b5b1872d, var_c2fd0740);
    if (isdefined(var_8c967549)) {
        yaw = baseangles[1] + var_8c967549;
    }
    if (isdefined(var_a17c7804)) {
        dist = var_a17c7804;
    }
    angles = (0, yaw, 0);
    dir = anglestoforward(angles);
    origin = baseorigin + dir * dist;
    if (var_13406a7f) {
        ignoreents = getentitiesinradius(self.origin, 500, 12);
        if (isdefined(ignoreent)) {
            if (!isdefined(ignoreents)) {
                ignoreents = [];
            } else if (!isarray(ignoreents)) {
                ignoreents = array(ignoreents);
            }
            ignoreents[ignoreents.size] = ignoreent;
        }
        tracestart = baseorigin + (0, 0, var_d0a44618);
        traceend = origin + (0, 0, var_d0a44618);
        traceresults = physicstraceex(tracestart, traceend, (0, 0, 0), (0, 0, 0), ignoreents, 1);
        /#
            if (var_ad49c795) {
                function_7289b47(index, "<dev string:x38>", tracestart, traceend, traceresults);
            }
        #/
        if (traceresults[#"fraction"] < 1) {
            origin = traceresults[#"position"];
            origin += dir * var_3512e170;
            origin -= (0, 0, var_d0a44618);
        } else {
            origin = traceend;
        }
        tracestart = origin;
        traceend = origin + (0, 0, var_172c8bf4);
        traceresults = physicstraceex(tracestart, traceend, (0, 0, 0), (0, 0, 0), ignoreents, 1);
        /#
            if (var_ad49c795) {
                function_7289b47(index, "<dev string:x3e>", tracestart + (0, 1, 0), traceend + (0, 1, 0), traceresults);
            }
        #/
        if (traceresults[#"fraction"] < 1) {
            origin = traceresults[#"position"] + (0, 0, var_f3e8e50d);
        } else {
            origin = traceend;
        }
        tracestart = origin;
        var_c99af8d9 = -1 * getdvarfloat(#"hash_52c51de092ea7057", 2000);
        traceend = origin + (0, 0, var_c99af8d9);
        traceresults = physicstraceex(tracestart, traceend, (0, 0, 0), (0, 0, 0), ignoreents, 1);
        /#
            if (var_ad49c795) {
                function_7289b47(index, "<dev string:x44>", tracestart, traceend, traceresults);
            }
        #/
        if (traceresults[#"fraction"] < 1) {
            origin = traceresults[#"position"] + (0, 0, var_7def9f0);
        } else {
            origin = (0, 0, 0);
            var_5d9d83c2 = 1;
        }
    } else {
        origin += (0, 0, var_7def9f0);
    }
    start_origin = baseorigin + (0, 0, 40);
    return {#start_origin:start_origin, #start_angles:angles, #end_origin:origin, #end_angles:angles};
}

// Namespace namespace_b637a3ed/namespace_b637a3ed
// Params 4, eflags: 0x1 linked
// Checksum 0xdbacb699, Offset: 0xbc8
// Size: 0x2bc
function function_fb72164f(index, baseorigin, baseangles, ignoreent) {
    assert(!isdefined(ignoreent) || isentity(ignoreent));
    var_ad49c795 = getdvarint(#"hash_730e73fdf6a44e00", 0);
    var_7def9f0 = 16;
    var_5d9d83c2 = 0;
    ignoreents = getentitiesinradius(self.origin, 500, 12);
    if (isdefined(ignoreent)) {
        if (!isdefined(ignoreents)) {
            ignoreents = [];
        } else if (!isarray(ignoreents)) {
            ignoreents = array(ignoreents);
        }
        ignoreents[ignoreents.size] = ignoreent;
    }
    origin = baseorigin;
    var_c99af8d9 = -1 * getdvarfloat(#"hash_52c51de092ea7057", 2000);
    traceend = baseorigin + (0, 0, var_c99af8d9);
    traceresults = physicstraceex(baseorigin, traceend, (0, 0, 0), (0, 0, 0), ignoreents, 1);
    /#
        if (var_ad49c795) {
            function_7289b47(index, "<dev string:x44>", baseorigin, traceend, traceresults);
        }
    #/
    if (traceresults[#"fraction"] < 1) {
        origin = traceresults[#"position"] + (0, 0, var_7def9f0);
    } else {
        origin = (0, 0, 0);
        var_5d9d83c2 = 1;
    }
    start_origin = baseorigin + (0, 0, 40);
    return {#start_origin:start_origin, #start_angles:baseangles, #end_origin:origin, #end_angles:baseangles};
}

/#

    // Namespace namespace_b637a3ed/namespace_b637a3ed
    // Params 5, eflags: 0x0
    // Checksum 0x164b732d, Offset: 0xe90
    // Size: 0x1d4
    function function_7289b47(index, name, start, end, traceresults) {
        var_e011538a = 2000;
        if (traceresults[#"fraction"] < 1) {
            line(start, traceresults[#"position"], (1, 0, 0), 1, 0, var_e011538a);
            debugaxis(traceresults[#"position"], (0, 0, 0), 10, 1, 1, var_e011538a);
            if (isdefined(traceresults[#"entity"])) {
                var_1143776a = traceresults[#"entity"];
                println("<dev string:x4a>" + index + "<dev string:x5c>" + name + "<dev string:x62>" + traceresults[#"fraction"] + "<dev string:x6b>" + var_1143776a.name);
            } else {
                println("<dev string:x4a>" + index + "<dev string:x5c>" + name + "<dev string:x62>" + traceresults[#"fraction"]);
            }
            return;
        }
        line(start, end, (1, 1, 1), 1, 0, var_e011538a);
    }

    // Namespace namespace_b637a3ed/namespace_b637a3ed
    // Params 1, eflags: 0x0
    // Checksum 0xbc5beafe, Offset: 0x1070
    // Size: 0xba
    function function_f6480a82(time) {
        var_e011538a = 2000;
        self endon(#"death");
        last_origin = self.origin;
        end_time = gettime() + int(time * 1000);
        while (gettime() < end_time) {
            waitframe(1);
            line(last_origin, self.origin, (0, 1, 0), 1, 1, var_e011538a);
            last_origin = self.origin;
        }
    }

#/
