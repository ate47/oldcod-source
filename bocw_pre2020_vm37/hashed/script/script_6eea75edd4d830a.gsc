#using script_37f9ff47f340fbe8;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;

#namespace namespace_ca99987f;

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 8, eflags: 0x0
// Checksum 0x31b239e0, Offset: 0x100
// Size: 0xa4
function function_86ac55c5(dvar, var_c7ec7d60, value, time, var_4ca73085, ease_in, ease_out, var_33ce6852) {
    self thread function_d4a4a726(getdvarfloat(dvar), value, time, &function_8ff186e5, var_4ca73085, "ease_dvar_" + dvar, "ease_dvar_" + dvar, ease_in, ease_out, var_33ce6852, dvar, var_c7ec7d60);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 8, eflags: 0x0
// Checksum 0xb61baa49, Offset: 0x1b0
// Size: 0x18c
function ease_origin(target, time, var_4ca73085, axis, additive, ease_in, ease_out, var_33ce6852) {
    assert(self != level);
    endons = undefined;
    callback = &function_54354e4e;
    var_be4baa48 = self.origin;
    if (is_true(additive)) {
        callback = &function_92b063ff;
    } else {
        endons = ["ease_origin", "ease_origin_x", "ease_origin_y", "ease_origin_z"];
    }
    if (isdefined(axis)) {
        assert(axis >= 0 && axis <= 2);
        var_be4baa48 = var_be4baa48[axis];
    } else {
        axis = -1;
    }
    self thread function_d4a4a726(var_be4baa48, target, time, callback, var_4ca73085, "ease_origin", endons, ease_in, ease_out, var_33ce6852, axis);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 8, eflags: 0x0
// Checksum 0x72b09158, Offset: 0x348
// Size: 0x18c
function ease_angles(target, time, var_4ca73085, axis, additive, ease_in, ease_out, var_33ce6852) {
    assert(self != level);
    endons = undefined;
    callback = &function_3b3f9801;
    var_be4baa48 = self.angles;
    if (is_true(additive)) {
        callback = &function_faea843b;
    } else {
        endons = ["ease_angles", "ease_pitch", "ease_yaw", "ease_roll"];
    }
    if (isdefined(axis)) {
        assert(axis >= 0 && axis <= 2);
        var_be4baa48 = var_be4baa48[axis];
    } else {
        axis = -1;
    }
    self thread function_d4a4a726(var_be4baa48, target, time, callback, var_4ca73085, "ease_angles", endons, ease_in, ease_out, var_33ce6852, axis);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 11, eflags: 0x20 variadic
// Checksum 0x5e8ee168, Offset: 0x4e0
// Size: 0x4fe
function function_d4a4a726(var_be4baa48, target_value, time, var_f71e2d8f, var_4ca73085 = #"linear", notifies, endons, ease_in, ease_out, var_33ce6852, ...) {
    assert(isdefined(level.var_b649495c));
    assert(isdefined(level.var_b649495c[var_4ca73085]));
    if (!isdefined(notifies)) {
        notifies = [];
    } else if (!isarray(notifies)) {
        notifies = array(notifies);
    }
    foreach (notify_str in notifies) {
        self notify(notify_str);
    }
    if (isdefined(endons)) {
        self endon(endons);
    }
    if (!isdefined(var_33ce6852)) {
        var_33ce6852 = [];
    } else if (!isarray(var_33ce6852)) {
        var_33ce6852 = array(var_33ce6852);
    }
    var_b3160f0 = spawnstruct();
    var_b3160f0.var_be4baa48 = var_be4baa48;
    var_b3160f0.target_value = target_value;
    var_b3160f0.var_872a88cd = var_be4baa48;
    var_b3160f0.var_37e98bce = 0;
    var_88a4b08c = var_b3160f0.var_872a88cd;
    for (cur_time = 0; cur_time < time; cur_time += float(function_60d95f53()) / 1000) {
        var_b3160f0.var_600ff81f = min(1, cur_time / time);
        var_88a4b08c = var_b3160f0.var_872a88cd;
        switch (var_33ce6852.size) {
        case 3:
            var_b3160f0.var_872a88cd = [[ level.var_b649495c[var_4ca73085] ]](var_be4baa48, target_value, var_b3160f0.var_600ff81f, ease_in, ease_out, var_33ce6852[0], var_33ce6852[1], var_33ce6852[2]);
            break;
        case 2:
            var_b3160f0.var_872a88cd = [[ level.var_b649495c[var_4ca73085] ]](var_be4baa48, target_value, var_b3160f0.var_600ff81f, ease_in, ease_out, var_33ce6852[0], var_33ce6852[1]);
            break;
        case 1:
            var_b3160f0.var_872a88cd = [[ level.var_b649495c[var_4ca73085] ]](var_be4baa48, target_value, var_b3160f0.var_600ff81f, ease_in, ease_out, var_33ce6852[0]);
            break;
        default:
            var_b3160f0.var_872a88cd = [[ level.var_b649495c[var_4ca73085] ]](var_be4baa48, target_value, var_b3160f0.var_600ff81f, ease_in, ease_out);
            break;
        }
        var_b3160f0.delta = var_b3160f0.var_872a88cd - var_88a4b08c;
        util::function_50f54b6f(self, var_f71e2d8f, var_b3160f0, vararg);
        waitframe(1);
    }
    var_b3160f0.var_872a88cd = target_value;
    var_b3160f0.delta = var_b3160f0.target_value - var_88a4b08c;
    var_b3160f0.var_37e98bce = 1;
    util::function_50f54b6f(self, var_f71e2d8f, var_b3160f0, vararg);
    if (isdefined(self)) {
        self notify(#"hash_133229f708f5d10", {#var_be4baa48:var_be4baa48, #target_value:target_value, #time:time, #var_f71e2d8f:var_f71e2d8f, #var_4ca73085:var_4ca73085});
    }
}

