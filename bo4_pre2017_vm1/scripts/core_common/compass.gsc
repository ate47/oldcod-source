#using scripts/core_common/struct;

#namespace compass;

// Namespace compass/compass
// Params 2, eflags: 0x0
// Checksum 0x3af41bf2, Offset: 0xe0
// Size: 0x38c
function setupminimap(material, zone) {
    if (!isdefined(material)) {
        material = "";
    }
    if (!isdefined(zone)) {
        zone = 0;
    }
    requiredmapaspectratio = getdvarfloat("scr_requiredMapAspectRatio");
    corners = getentarray("minimap_corner", "targetname");
    if (corners.size != 2) {
        println("<dev string:x28>");
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
    setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1]);
    setminimapzone(northwest[0], northwest[1], southeast[0], southeast[1]);
}

// Namespace compass/compass
// Params 1, eflags: 0x0
// Checksum 0x70c2bb7c, Offset: 0x478
// Size: 0x304
function setupminimapzone(zone) {
    corners = getentarray("zone_0" + zone + "_corner", "targetname");
    if (corners.size != 2) {
        println("<dev string:x28>");
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
// Checksum 0x5eedf2c1, Offset: 0x788
// Size: 0x44
function vecscale(vec, scalar) {
    return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

