#using scripts/core_common/util_shared;

#namespace math;

// Namespace math/math_shared
// Params 0, eflags: 0x0
// Checksum 0x23ad058a, Offset: 0xc8
// Size: 0x20
function cointoss() {
    return randomint(100) >= 50;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0x78d6c9cd, Offset: 0xf0
// Size: 0x68
function clamp(val, val_min, val_max) {
    if (!isdefined(val_max)) {
        val_max = val;
    }
    if (val < val_min) {
        val = val_min;
    } else if (val > val_max) {
        val = val_max;
    }
    return val;
}

// Namespace math/math_shared
// Params 5, eflags: 0x0
// Checksum 0x9d6b9b57, Offset: 0x160
// Size: 0x6a
function linear_map(num, min_a, max_a, min_b, max_b) {
    return clamp((num - min_a) / (max_a - min_a) * (max_b - min_b) + min_b, min_b, max_b);
}

// Namespace math/math_shared
// Params 4, eflags: 0x0
// Checksum 0x788a2df, Offset: 0x1d8
// Size: 0xa6
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
// Checksum 0x20c41c1, Offset: 0x288
// Size: 0x76
function find_box_center(mins, maxs) {
    center = (0, 0, 0);
    center = maxs - mins;
    center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
    return center;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0x1b639eaa, Offset: 0x308
// Size: 0xce
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
// Checksum 0xb45f8e61, Offset: 0x3e0
// Size: 0xce
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
// Checksum 0x7fb0231, Offset: 0x4b8
// Size: 0xb4
function vector_compare(vec1, vec2) {
    return abs(vec1[0] - vec2[0]) < 0.001 && abs(vec1[1] - vec2[1]) < 0.001 && abs(vec1[2] - vec2[2]) < 0.001;
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0x1180b93, Offset: 0x578
// Size: 0x6c
function random_vector(max_length) {
    return (randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length));
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0xa19adb29, Offset: 0x5f0
// Size: 0x76
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
// Checksum 0x44df28a7, Offset: 0x670
// Size: 0x24
function sign(x) {
    return x >= 0 ? 1 : -1;
}

// Namespace math/math_shared
// Params 0, eflags: 0x0
// Checksum 0x3e84aee8, Offset: 0x6a0
// Size: 0x2e
function randomsign() {
    return randomintrange(-1, 1) >= 0 ? 1 : -1;
}

// Namespace math/math_shared
// Params 5, eflags: 0x0
// Checksum 0xc7c61f0e, Offset: 0x6d8
// Size: 0x394
function get_dot_direction(v_point, b_ignore_z, b_normalize, str_direction, b_use_eye) {
    /#
        assert(isdefined(v_point), "<dev string:x28>");
    #/
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
        /#
            assertmsg(str_direction + "<dev string:x54>");
        #/
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
// Checksum 0x3dab2394, Offset: 0xa78
// Size: 0x7c
function get_dot_right(v_point, b_ignore_z, b_normalize) {
    /#
        assert(isdefined(v_point), "<dev string:x7f>");
    #/
    n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "right");
    return n_dot;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0xd864b67c, Offset: 0xb00
// Size: 0x7c
function get_dot_up(v_point, b_ignore_z, b_normalize) {
    /#
        assert(isdefined(v_point), "<dev string:xb1>");
    #/
    n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "up");
    return n_dot;
}

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0x43341939, Offset: 0xb88
// Size: 0x7c
function get_dot_forward(v_point, b_ignore_z, b_normalize) {
    /#
        assert(isdefined(v_point), "<dev string:xe0>");
    #/
    n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, "forward");
    return n_dot;
}

// Namespace math/math_shared
// Params 4, eflags: 0x0
// Checksum 0xab85bd00, Offset: 0xc10
// Size: 0xe4
function get_dot_from_eye(v_point, b_ignore_z, b_normalize, str_direction) {
    /#
        assert(isdefined(v_point), "<dev string:xe0>");
    #/
    /#
        assert(isplayer(self) || isai(self), "<dev string:x114>" + self.classname + "<dev string:x134>");
    #/
    n_dot = get_dot_direction(v_point, b_ignore_z, b_normalize, str_direction, 1);
    return n_dot;
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0xabb9758f, Offset: 0xd00
// Size: 0xb8
function array_average(array) {
    /#
        assert(isarray(array));
    #/
    /#
        assert(array.size > 0);
    #/
    total = 0;
    for (i = 0; i < array.size; i++) {
        total += array[i];
    }
    return total / array.size;
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0x1bbe136c, Offset: 0xdc0
// Size: 0x132
function array_std_deviation(array, mean) {
    /#
        assert(isarray(array));
    #/
    /#
        assert(array.size > 0);
    #/
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
// Checksum 0x225c0f1a, Offset: 0xf00
// Size: 0x19e
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
// Checksum 0x881a22e9, Offset: 0x10a8
// Size: 0x148
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
// Checksum 0xc66b147b, Offset: 0x11f8
// Size: 0x1c0
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
// Params 2, eflags: 0x0
// Checksum 0xe226c65a, Offset: 0x13c0
// Size: 0x62
function get_2d_yaw(start, end) {
    vector = (end[0] - start[0], end[1] - start[1], 0);
    return vec_to_angles(vector);
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0x2a3dd1a8, Offset: 0x1430
// Size: 0xde
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
// Checksum 0x4bc9b765, Offset: 0x1518
// Size: 0x7a
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

