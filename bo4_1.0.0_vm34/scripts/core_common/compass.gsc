#using scripts\core_common\match_record;

#namespace compass;

// Namespace compass/compass
// Params 2, eflags: 0x0
// Checksum 0x946d738f, Offset: 0xd0
// Size: 0x38c
function setupminimap(material = "", zone = 0) {
    requiredmapaspectratio = getdvarfloat(#"scr_requiredmapaspectratio", 0);
    corners = getentarray("minimap_corner", "targetname");
    if (corners.size != 2) {
        println("<dev string:x30>");
        return;
    }
    corner0 = (corners[0].origin[0], corners[0].origin[1], 0);
    corner1 = (corners[1].origin[0], corners[1].origin[1], 0);
    match_record::function_3fad861b("compass_map_upper_left", corner0);
    match_record::function_3fad861b("compass_map_lower_right", corner1);
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
// Checksum 0x5a511b71, Offset: 0x468
// Size: 0x2d4
function setupminimapzone(zone) {
    corners = getentarray("zone_0" + zone + "_corner", "targetname");
    if (corners.size != 2) {
        println("<dev string:x30>");
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
// Params 2, eflags: 0x0
// Checksum 0x3890d5f6, Offset: 0x748
// Size: 0x44
function vecscale(vec, scalar) {
    return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

