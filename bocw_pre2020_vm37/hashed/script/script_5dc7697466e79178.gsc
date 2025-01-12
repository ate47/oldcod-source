#using scripts\core_common\array_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace location;

// Namespace location/location
// Params 0, eflags: 0x6
// Checksum 0xdd87dff9, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"location", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace location/location
// Params 0, eflags: 0x5 linked
// Checksum 0x2876a559, Offset: 0xd0
// Size: 0x24
function private function_70a657d8() {
    level.locations = [];
    function_d1b7504e();
}

// Namespace location/location
// Params 0, eflags: 0x1 linked
// Checksum 0x3fbc8f92, Offset: 0x100
// Size: 0x10c
function function_d1b7504e() {
    var_74fed7b1 = struct::get_array("map_location");
    foreach (map_location in var_74fed7b1) {
        if (!isdefined(level.location)) {
            level.location = [];
        } else if (!isarray(level.location)) {
            level.location = array(level.location);
        }
        level.location[level.location.size] = map_location;
    }
}

// Namespace location/location
// Params 4, eflags: 0x0
// Checksum 0xf8bd9516, Offset: 0x218
// Size: 0xfc
function function_18dac968(origin, height, width, radius) {
    location = {#origin:origin, #height:height, #width:width, #radius:radius};
    if (!isdefined(level.location)) {
        level.location = [];
    } else if (!isarray(level.location)) {
        level.location = array(level.location);
    }
    level.location[level.location.size] = location;
    return location;
}

// Namespace location/location
// Params 0, eflags: 0x0
// Checksum 0x6eac436c, Offset: 0x320
// Size: 0x1a
function function_2e7ce8a0() {
    return array::random(level.location);
}

// Namespace location/location
// Params 1, eflags: 0x0
// Checksum 0x6445c242, Offset: 0x348
// Size: 0x108
function function_98eed213(location) {
    xoffset = 0;
    yoffset = 0;
    if (location.width > 0) {
        halfwidth = location.width / 2;
        xoffset = randomfloatrange(halfwidth * -1, halfwidth);
    }
    if (location.height > 0) {
        halfheight = location.height / 2;
        yoffset = randomfloatrange(halfheight * -1, halfheight);
    }
    origin = (location.origin[0] + xoffset, location.origin[1] + yoffset, location.origin[2]);
    return origin;
}

