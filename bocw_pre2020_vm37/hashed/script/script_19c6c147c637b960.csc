#using scripts\core_common\struct;

#namespace territory;

// Namespace territory/namespace_c5b35f33
// Params 0, eflags: 0x1 linked
// Checksum 0x194ceef6, Offset: 0x70
// Size: 0x32
function function_c0de0601() {
    return isdefined(level.territory) && level.territory.name != "";
}

// Namespace territory/namespace_c5b35f33
// Params 1, eflags: 0x0
// Checksum 0x867eadf8, Offset: 0xb0
// Size: 0xf6
function get_center(territory = level.territory) {
    center = (0, 0, 0);
    if (!function_c0de0601() || territory.bounds.size <= 0) {
        return center;
    }
    foreach (boundary in territory.bounds) {
        center += boundary.origin;
    }
    return center / territory.bounds.size;
}

// Namespace territory/namespace_c5b35f33
// Params 1, eflags: 0x0
// Checksum 0x26060d7c, Offset: 0x1b0
// Size: 0x230
function get_radius(territory = level.territory) {
    absmins = [];
    absmaxs = [];
    if (!isstruct(territory) || !isarray(territory.bounds)) {
        return;
    }
    foreach (bound in territory.bounds) {
        var_f3ba0cb3 = bound.origin + bound.mins;
        var_cd8bd6d = bound.origin + bound.maxs;
        for (i = 0; i < 3; i++) {
            if (!isdefined(absmins[i])) {
                absmins[i] = var_f3ba0cb3[i];
            }
            if (!isdefined(absmaxs[i])) {
                absmaxs[i] = var_cd8bd6d[i];
            }
            absmins[i] = min(absmins[i], var_f3ba0cb3[i]);
            absmaxs[i] = max(absmaxs[i], var_cd8bd6d[i]);
        }
    }
    absmin = (absmins[0], absmins[1], 0);
    absmax = (absmaxs[0], absmaxs[1], 0);
    return distance2d(absmin, absmax) / 2;
}

// Namespace territory/namespace_c5b35f33
// Params 3, eflags: 0x1 linked
// Checksum 0xe648b52b, Offset: 0x3e8
// Size: 0x18a
function is_inside(point, var_73362d27 = 0, territory = level.territory) {
    if (!function_c0de0601()) {
        return true;
    }
    if (!isvec(point)) {
        assert(0);
        return false;
    }
    if (!isdefined(territory.bounds) || territory.bounds.size == 0) {
        return true;
    }
    foreach (boundary in territory.bounds) {
        testpoint = point;
        if (var_73362d27) {
            testpoint = (testpoint[0], testpoint[1], boundary.origin[2]);
        }
        if (boundary istouching(testpoint)) {
            return true;
        }
    }
    return false;
}

// Namespace territory/namespace_c5b35f33
// Params 2, eflags: 0x1 linked
// Checksum 0xccfae3aa, Offset: 0x580
// Size: 0x6a
function is_valid(object, territory = level.territory) {
    if (isdefined(territory.script_territory) && isdefined(object.script_territory) && territory.script_territory != object.script_territory) {
        return false;
    }
    return true;
}

// Namespace territory/namespace_c5b35f33
// Params 2, eflags: 0x0
// Checksum 0x22c9effb, Offset: 0x5f8
// Size: 0x2dc
function function_b3791221(var_d1373160 = 10, territory = level.territory) {
    if (!function_c0de0601()) {
        return;
    }
    absmins = [];
    absmaxs = [];
    if (!isstruct(territory) || !isarray(territory.bounds)) {
        return;
    }
    foreach (bound in territory.bounds) {
        var_f3ba0cb3 = bound.origin + bound.mins;
        var_cd8bd6d = bound.origin + bound.maxs;
        for (i = 0; i < 3; i++) {
            if (!isdefined(absmins[i])) {
                absmins[i] = var_f3ba0cb3[i];
            }
            if (!isdefined(absmaxs[i])) {
                absmaxs[i] = var_cd8bd6d[i];
            }
            absmins[i] = min(absmins[i], var_f3ba0cb3[i]);
            absmaxs[i] = max(absmaxs[i], var_cd8bd6d[i]);
        }
    }
    if (absmins.size <= 0 || absmaxs.size <= 0) {
        return;
    }
    for (index = 0; index < var_d1373160; index++) {
        point = [];
        for (i = 0; i < 3; i++) {
            point[i] = randomfloatrange(absmins[i], absmaxs[i]);
        }
        randompoint = (point[0], point[1], point[2]);
        if (is_inside(randompoint, undefined, territory)) {
            return randompoint;
        }
    }
}

// Namespace territory/namespace_c5b35f33
// Params 3, eflags: 0x1 linked
// Checksum 0xfd9340f8, Offset: 0x8e0
// Size: 0x6a
function function_5c7345a3(name, key, territory = level.territory) {
    structs = struct::get_array(name, key);
    return function_39dd704c(structs, territory);
}

// Namespace territory/namespace_c5b35f33
// Params 2, eflags: 0x1 linked
// Checksum 0xa2998cc6, Offset: 0x958
// Size: 0x19e
function function_39dd704c(objects, territory) {
    validobjects = [];
    if (!isdefined(territory) || !isdefined(territory.name) || territory.name == "") {
        foreach (object in objects) {
            if (!isdefined(object.script_territory)) {
                validobjects[validobjects.size] = object;
            }
        }
    } else {
        foreach (object in objects) {
            if (!is_valid(object, territory)) {
                continue;
            }
            if (!is_inside(object.origin, undefined, territory)) {
                continue;
            }
            validobjects[validobjects.size] = object;
        }
    }
    return validobjects;
}

