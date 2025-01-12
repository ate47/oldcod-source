#using scripts\core_common\util_shared;

#namespace math;

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0x1600ff39, Offset: 0x88
// Size: 0x38
function cointoss(n_chance = 50) {
    return randomintrangeinclusive(1, 100) <= n_chance;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0xbdc04aef, Offset: 0xc8
// Size: 0x5c
function clamp(val, val_min, val_max = val) {
    if (val < val_min) {
        val = val_min;
    } else if (val > val_max) {
        val = val_max;
    }
    return val;
}

// Namespace math/math_shared
// Params 5, eflags: 0x0
// Checksum 0xf86fc9da, Offset: 0x130
// Size: 0x6a
function linear_map(num, min_a, max_a, min_b, max_b) {
    return clamp((num - min_a) / (max_a - min_a) * (max_b - min_b) + min_b, min_b, max_b);
}

// Namespace math/math_shared
// Params 4, eflags: 0x0
// Checksum 0xce83ce5b, Offset: 0x1a8
// Size: 0x9e
function lag(desired, curr, k, dt) {
    r = 0;
    if (k * dt >= 1 || k <= 0) {
        r = desired;
    } else {
        err = desired - curr;
        r = curr + k * err * dt;
    }
    return r;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0xbd4dc941, Offset: 0x250
// Size: 0x70
function find_box_center(mins, maxs) {
    center = (0, 0, 0);
    center = maxs - mins;
    center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
    return center;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0x24625655, Offset: 0x2c8
// Size: 0xc2
function expand_mins(mins, point) {
    if (mins[0] > point[0]) {
        mins = (point[0], mins[1], mins[2]);
    }
    if (mins[1] > point[1]) {
        mins = (mins[0], point[1], mins[2]);
    }
    if (mins[2] > point[2]) {
        mins = (mins[0], mins[1], point[2]);
    }
    return mins;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0xa41400e4, Offset: 0x398
// Size: 0xc2
function expand_maxs(maxs, point) {
    if (maxs[0] < point[0]) {
        maxs = (point[0], maxs[1], maxs[2]);
    }
    if (maxs[1] < point[1]) {
        maxs = (maxs[0], point[1], maxs[2]);
    }
    if (maxs[2] < point[2]) {
        maxs = (maxs[0], maxs[1], point[2]);
    }
    return maxs;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0xbd9424e5, Offset: 0x468
// Size: 0xb6
function vector_compare(vec1, vec2) {
    return abs(vec1[0] - vec2[0]) < 0.001 && abs(vec1[1] - vec2[1]) < 0.001 && abs(vec1[2] - vec2[2]) < 0.001;
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0x1d42809e, Offset: 0x528
// Size: 0x6c
function random_vector(max_length) {
    return (randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length));
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0x998f2083, Offset: 0x5a0
// Size: 0x6c
function angle_dif(oldangle, newangle) {
    outvalue = (oldangle - newangle) % 360;
    if (outvalue < 0) {
        outvalue += 360;
    }
    if (outvalue > 180) {
        outvalue = (outvalue - 360) * -1;
    }
    return outvalue;
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0xcf67cf9a, Offset: 0x618
// Size: 0x24
function sign(x) {
    return x >= 0 ? 1 : -1;
}

// Namespace math/math_shared
// Params 0, eflags: 0x0
// Checksum 0x4b5aa3ce, Offset: 0x648
// Size: 0x2e
function randomsign() {
    return randomintrange(-1, 1) >= 0 ? 1 : -1;
}

// Namespace math/math_shared
// Params 5, eflags: 0x0
// Checksum 0x873051a2, Offset: 0x680
// Size: 0x36a
function get_dot_direction(v_point, b_ignore_z, b_normalize, str_direction, b_use_eye) {
    assert(isdefined(v_point), "<dev string:x30>");
    if (!isdefined(b_ignore_z)) {
        b_ignore_z = 0;
    }
    if (!isdefined(b_normalize)) {
        b_normalize = 1;
    }
    if (!isdefined(str_direction)) {
        str_direction = "forward";
    }
    if (!isdefined(b_use_eye)) {
        b_use_eye = 0;
        if (isplayer(self)) {
            b_use_eye = 1;
        }
    }
    v_angles = self.angles;
    v_origin = self.origin;
    if (b_use_eye) {
        v_origin = self util::get_eye();
    }
    if (isplayer(self)) {
        v_angles = self getplayerangles();
        if (level.wiiu) {
            v_angles = self getgunangles();
        }
    }
    if (b_ignore_z) {
        v_angles = (v_angles[0], v_angles[1], 0);
        v_point = (v_point[0], v_point[1], 0);
        v_origin = (v_origin[0], v_origin[1], 0);
    }
    switch (str_direction) {
    case #"forward":
        v_direction = anglestoforward(v_angles);
        break;
    case #"backward":
        v_direction = anglestoforward(v_angles) * -1;
        break;
    case #"right":
        v_direction = anglestoright(v_angles);
        break;
    case #"left":
        v_direction = anglestoright(v_angles) * -1;
        break;
    case #"up":
        v_direction = anglestoup(v_angles);
        break;
    case #"down":
        v_direction = anglestoup(v_angles) * -1;
        break;
    default:
        assertmsg(str_direction + "<dev string:x5c>");
        v_direction = anglestoforward(v_angles);
        break;
    }
    v_to_point = v_point - v_origin;
    if (b_normalize) {
        v_to_point = vectornormalize(v_to_point);
    }
    n_dot = vectordot(v_direction, v_to_point);
    return n_dot;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0x2d86e13c, Offset: 0x9f8
// Size: 0x72
function get_dot_right(v_point, b_ignore_z, b_normalize) {
    assert(isdefined(v_point), "<dev string:x87>");
    n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "right");
    return n_dot;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0x9efc8b9, Offset: 0xa78
// Size: 0x72
function get_dot_up(v_point, b_ignore_z, b_normalize) {
    assert(isdefined(v_point), "<dev string:xb9>");
    n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "up");
    return n_dot;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0x7d0fb041, Offset: 0xaf8
// Size: 0x72
function get_dot_forward(v_point, b_ignore_z, b_normalize) {
    assert(isdefined(v_point), "<dev string:xe8>");
    n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "forward");
    return n_dot;
}

// Namespace math/math_shared
// Params 4, eflags: 0x0
// Checksum 0xb8b86270, Offset: 0xb78
// Size: 0xda
function get_dot_from_eye(v_point, b_ignore_z, b_normalize, str_direction) {
    assert(isdefined(v_point), "<dev string:xe8>");
    assert(isplayer(self) || isai(self), "<dev string:x11c>" + self.classname + "<dev string:x13c>");
    n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, str_direction, 1);
    return n_dot;
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0xcb1668f9, Offset: 0xc60
// Size: 0xa8
function array_average(array) {
    assert(isarray(array));
    assert(array.size > 0);
    total = 0;
    for (i = 0; i < array.size; i++) {
        total += array[i];
    }
    return total / array.size;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0x6435f530, Offset: 0xd10
// Size: 0x11a
function array_std_deviation(array, mean) {
    assert(isarray(array));
    assert(array.size > 0);
    tmp = [];
    for (i = 0; i < array.size; i++) {
        tmp[i] = (array[i] - mean) * (array[i] - mean);
    }
    total = 0;
    for (i = 0; i < tmp.size; i++) {
        total += tmp[i];
    }
    return sqrt(total / array.size);
}

// Namespace math/math_shared
// Params 4, eflags: 0x0
// Checksum 0x6984341d, Offset: 0xe38
// Size: 0x184
function random_normal_distribution(mean, std_deviation, lower_bound, upper_bound) {
    x1 = 0;
    x2 = 0;
    w = 1;
    y1 = 0;
    while (w >= 1) {
        x1 = 2 * randomfloatrange(0, 1) - 1;
        x2 = 2 * randomfloatrange(0, 1) - 1;
        w = x1 * x1 + x2 * x2;
    }
    w = sqrt(-2 * log(w) / w);
    y1 = x1 * w;
    number = mean + y1 * std_deviation;
    if (isdefined(lower_bound) && number < lower_bound) {
        number = lower_bound;
    }
    if (isdefined(upper_bound) && number > upper_bound) {
        number = upper_bound;
    }
    return number;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0xd0640c04, Offset: 0xfc8
// Size: 0x13e
function point_on_sphere_even_distribution(pitchrange, index, numberofpoints) {
    zrange = mapfloat(0, 180, 1, -1, pitchrange);
    golden_angle = 180 * (3 - sqrt(5));
    theta = index * golden_angle;
    z = mapfloat(0, numberofpoints - 1, 1, zrange, index);
    r = sqrt(1 - z * z);
    dir = (r * cos(theta), r * sin(theta), z);
    return dir;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0xf9d18c8c, Offset: 0x1110
// Size: 0x1a8
function closest_point_on_line(point, linestart, lineend) {
    linemagsqrd = lengthsquared(lineend - linestart);
    t = ((point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2])) / linemagsqrd;
    if (t < 0) {
        return linestart;
    } else if (t > 1) {
        return lineend;
    }
    start_x = linestart[0] + t * (lineend[0] - linestart[0]);
    start_y = linestart[1] + t * (lineend[1] - linestart[1]);
    start_z = linestart[2] + t * (lineend[2] - linestart[2]);
    return (start_x, start_y, start_z);
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0x60f13e99, Offset: 0x12c0
// Size: 0xc4
function function_a0978b54(linestart, lineend, point) {
    var_211ac92b = distancesquared(linestart, point);
    var_dd3a470c = distancesquared(lineend, point);
    lengthsq = lengthsquared(lineend - linestart);
    if (var_211ac92b > lengthsq || var_dd3a470c > lengthsq) {
        point = var_211ac92b > var_dd3a470c ? lineend : linestart;
    }
    return point;
}

// Namespace math/math_shared
// Params 5, eflags: 0x0
// Checksum 0x864702f7, Offset: 0x1390
// Size: 0x1ca
function function_e305c083(var_856654a6, var_c3f90f0b, var_5f63da3d, var_51f19fd0, clamp) {
    veca = var_c3f90f0b - var_856654a6;
    vecb = var_51f19fd0 - var_5f63da3d;
    vecc = var_5f63da3d - var_856654a6;
    dotaa = vectordot(veca, veca);
    dotab = vectordot(veca, vecb);
    dotac = vectordot(veca, vecc);
    dotbb = vectordot(vecb, vecb);
    dotbc = vectordot(vecb, vecc);
    denom = dotaa * dotbb - dotab * dotab;
    if (denom == 0) {
        return undefined;
    }
    t = (dotab * -1 * dotbc + dotac * dotbb) / (dotaa * dotbb - dotab * dotab);
    point = var_856654a6 + veca * t;
    if (clamp) {
        point = function_a0978b54(var_856654a6, var_c3f90f0b, point);
    }
    return point;
}

// Namespace math/math_shared
// Params 5, eflags: 0x0
// Checksum 0xaf310419, Offset: 0x1568
// Size: 0x29c
function function_5b5ab257(var_856654a6, var_c3f90f0b, var_5f63da3d, var_51f19fd0, clamp) {
    veca = var_c3f90f0b - var_856654a6;
    vecb = var_51f19fd0 - var_5f63da3d;
    vecc = var_5f63da3d - var_856654a6;
    dotaa = vectordot(veca, veca);
    dotab = vectordot(veca, vecb);
    dotac = vectordot(veca, vecc);
    dotbb = vectordot(vecb, vecb);
    dotbc = vectordot(vecb, vecc);
    var_fec8c71b = dotaa * dotbb - dotab * dotab;
    var_8cc157e0 = dotaa * dotbb - dotab * dotab;
    if (var_fec8c71b == 0 || var_8cc157e0 == 0) {
        return undefined;
    }
    ta = (dotab * -1 * dotbc + dotac * dotbb) / (dotaa * dotbb - dotab * dotab);
    tb = (dotab * dotac - dotbc * dotaa) / (dotaa * dotbb - dotab * dotab);
    pointa = var_856654a6 + veca * ta;
    pointb = var_5f63da3d + vecb * tb;
    if (clamp) {
        pointa = function_a0978b54(var_856654a6, var_c3f90f0b, pointa);
        pointb = function_a0978b54(var_5f63da3d, var_51f19fd0, pointb);
    }
    pointstruct = {#pointa:pointa, #pointb:pointb};
    return pointstruct;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0x61093445, Offset: 0x1810
// Size: 0x62
function get_2d_yaw(start, end) {
    vector = (end[0] - start[0], end[1] - start[1], 0);
    return vec_to_angles(vector);
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0xaa3e53fd, Offset: 0x1880
// Size: 0xd0
function vec_to_angles(vector) {
    yaw = 0;
    vecx = vector[0];
    vecy = vector[1];
    if (vecx == 0 && vecy == 0) {
        return 0;
    }
    if (vecy < 0.001 && vecy > -0.001) {
        vecy = 0.001;
    }
    yaw = atan(vecx / vecy);
    if (vecy < 0) {
        yaw += 180;
    }
    return 90 - yaw;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0x8b34f768, Offset: 0x1958
// Size: 0x72
function pow(base, exp) {
    if (exp == 0) {
        return 1;
    }
    result = base;
    for (i = 0; i < exp - 1; i++) {
        result *= base;
    }
    return result;
}

