#namespace math;

// Namespace math/math_shared
// Params 3, eflags: 0x0
// Checksum 0x2a615c8e, Offset: 0x60
// Size: 0x44
function clamp(val, val_min, val_max) {
    if (val < val_min) {
        val = val_min;
    } else if (val > val_max) {
        val = val_max;
    }
    return val;
}

// Namespace math/math_shared
// Params 4, eflags: 0x0
// Checksum 0x406f5590, Offset: 0xb0
// Size: 0x92
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
// Params 1, eflags: 0x0
// Checksum 0xaca83857, Offset: 0x150
// Size: 0x98
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
// Checksum 0xaeb244da, Offset: 0x1f0
// Size: 0xfa
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
// Params 2, eflags: 0x0
// Checksum 0xed615950, Offset: 0x2f8
// Size: 0x9e
function vector_compare(vec1, vec2) {
    return abs(vec1[0] - vec2[0]) < 0.001 && abs(vec1[1] - vec2[1]) < 0.001 && abs(vec1[2] - vec2[2]) < 0.001;
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0x94164cd0, Offset: 0x3a0
// Size: 0x6c
function random_vector(max_length) {
    return (randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length));
}

// Namespace math/math_shared
// Params 2, eflags: 0x0
// Checksum 0x75bea4b1, Offset: 0x418
// Size: 0x68
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
// Checksum 0x33dda431, Offset: 0x488
// Size: 0x22
function sign(x) {
    if (x >= 0) {
        return 1;
    }
    return -1;
}

// Namespace math/math_shared
// Params 0, eflags: 0x0
// Checksum 0x3a8f5f69, Offset: 0x4b8
// Size: 0x2e
function randomsign() {
    return randomintrange(-1, 1) >= 0 ? 1 : -1;
}

// Namespace math/math_shared
// Params 1, eflags: 0x0
// Checksum 0x49950c39, Offset: 0x4f0
// Size: 0x38
function cointoss(n_chance = 50) {
    return randomintrangeinclusive(1, 100) <= n_chance;
}

