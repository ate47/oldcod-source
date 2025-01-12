#using script_d9b5c8b1ad38ef5;
#using scripts\core_common\match_record;

#namespace compass;

// Namespace compass/compass
// Params 2, eflags: 0x1 linked
// Checksum 0xa98ee6da, Offset: 0xe0
// Size: 0x14c
function setupminimap(material, *zone = "") {
    requiredmapaspectratio = getdvarfloat(#"scr_requiredmapaspectratio", 0);
    corners = territory::function_1f583d2e("minimap_corner", "targetname");
    if (corners.size == 0) {
        corners = territory::function_1deaf019("minimap_corner", "targetname", "");
    }
    if (corners.size != 2) {
        println("<dev string:x38>");
        return;
    }
    function_d6cba2e9(zone, corners[0].origin[0], corners[0].origin[1], corners[1].origin[0], corners[1].origin[1]);
}

// Namespace compass/compass
// Params 5, eflags: 0x1 linked
// Checksum 0x92b48568, Offset: 0x238
// Size: 0x2a4
function function_d6cba2e9(material = "", var_56a8cb79, var_47612cea, var_49fcbf2c, var_9815db69) {
    corner0 = (var_56a8cb79, var_47612cea, 0);
    corner1 = (var_49fcbf2c, var_9815db69, 0);
    match_record::function_7a93acec("compass_map_upper_left", corner0);
    match_record::function_7a93acec("compass_map_lower_right", corner1);
    cornerdiff = corner1 - corner0;
    north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
    west = (0 - north[1], north[0], 0);
    if (vectordot(cornerdiff, west) > 0) {
        if (vectordot(cornerdiff, north) > 0) {
            northwest = corner1;
            southeast = corner0;
        } else {
            side = vecscale(north, vectordot(cornerdiff, north));
            northwest = corner1 - side;
            southeast = corner0 + side;
        }
    } else if (vectordot(cornerdiff, north) > 0) {
        side = vecscale(north, vectordot(cornerdiff, north));
        northwest = corner0 + side;
        southeast = corner1 - side;
    } else {
        northwest = corner0;
        southeast = corner1;
    }
    setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1]);
    setminimapzone(northwest[0], northwest[1], southeast[0], southeast[1]);
}

// Namespace compass/compass
// Params 1, eflags: 0x0
// Checksum 0x6611f7c, Offset: 0x4e8
// Size: 0x2b4
function setupminimapzone(zone) {
    corners = getentarray("zone_0" + zone + "_corner", "targetname");
    if (corners.size != 2) {
        println("<dev string:x38>");
        return;
    }
    corner0 = (corners[0].origin[0], corners[0].origin[1], 0);
    corner1 = (corners[1].origin[0], corners[1].origin[1], 0);
    cornerdiff = corner1 - corner0;
    north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
    west = (0 - north[1], north[0], 0);
    if (vectordot(cornerdiff, west) > 0) {
        if (vectordot(cornerdiff, north) > 0) {
            northwest = corner1;
            southeast = corner0;
        } else {
            side = vecscale(north, vectordot(cornerdiff, north));
            northwest = corner1 - side;
            southeast = corner0 + side;
        }
    } else if (vectordot(cornerdiff, north) > 0) {
        side = vecscale(north, vectordot(cornerdiff, north));
        northwest = corner0 + side;
        southeast = corner1 - side;
    } else {
        northwest = corner0;
        southeast = corner1;
    }
    setminimapzone(northwest[0], northwest[1], southeast[0], southeast[1]);
}

// Namespace compass/compass
// Params 2, eflags: 0x1 linked
// Checksum 0xf88c4f99, Offset: 0x7a8
// Size: 0x3e
function vecscale(vec, scalar) {
    return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

