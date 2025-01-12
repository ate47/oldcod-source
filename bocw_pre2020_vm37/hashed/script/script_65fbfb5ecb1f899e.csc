#using script_140d5347de8af85c;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;

#namespace namespace_ca99987f;

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 8, eflags: 0x0
// Checksum 0xfd523d2e, Offset: 0x1c0
// Size: 0xac
function function_a037b7c9(localclientnum, ui_model, value, time, var_4ca73085, ease_in, ease_out, var_33ce6852) {
    self thread function_d4a4a726(localclientnum, getuimodelvalue(ui_model), value, time, &function_3d07aeab, var_4ca73085, "ease_uimodel_" + ui_model, "ease_uimodel_" + ui_model, ease_in, ease_out, var_33ce6852, ui_model);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 7, eflags: 0x0
// Checksum 0xf4349a8e, Offset: 0x278
// Size: 0xec
function ease_camera_position(start, target, time, var_4ca73085, ease_in, ease_out, var_33ce6852) {
    assert(self isplayer());
    if (!isdefined(start)) {
        start = self getcampos();
    }
    localclientnum = self getlocalclientnumber();
    self thread function_d4a4a726(localclientnum, start, target, time, &function_5b854508, var_4ca73085, "ease_camera_position", "ease_camera_position", ease_in, ease_out, var_33ce6852);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 7, eflags: 0x0
// Checksum 0x6199a323, Offset: 0x370
// Size: 0x124
function ease_camera_angles(start, target, time, var_4ca73085, ease_in, ease_out, var_33ce6852) {
    assert(self isplayer());
    if (!isdefined(start)) {
        start = self getcamangles();
    }
    start = angleclamp180(start);
    target = start + angleclamp180(target - start);
    localclientnum = self getlocalclientnumber();
    self thread function_d4a4a726(localclientnum, start, target, time, &function_d4923609, var_4ca73085, "ease_camera_angles", "ease_camera_angles", ease_in, ease_out, var_33ce6852);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 7, eflags: 0x0
// Checksum 0x5cc320d4, Offset: 0x4a0
// Size: 0x22c
function function_f95cb457(start, target, time, var_4ca73085, ease_in, ease_out, var_33ce6852) {
    assert(self isplayer());
    assert(target > 0);
    if (!isdefined(start) && var_4ca73085 == #"linear") {
        self function_49cdf043(max(1e-05, target), time);
        return;
    }
    var_aca17b66 = self function_82f1cbd2();
    if (!isdefined(start)) {
        start = var_aca17b66;
    }
    if (getdvarint(#"hash_32f02866d46e6e7b", 0)) {
        var_18b7d7a4 = self function_838f0a04();
        delta = var_18b7d7a4 - getdvarfloat(#"cg_focallength", var_18b7d7a4);
        if (abs(delta) > 0.001) {
            start -= delta;
        }
    }
    localclientnum = self getlocalclientnumber();
    self thread function_d4a4a726(localclientnum, start, target, time, &function_c426caa9, var_4ca73085, "ease_camera_lens_focal_length", ["ease_camera_lens_focal_length", "deactivate_camera_lens_overrides"], ease_in, ease_out, var_33ce6852);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 7, eflags: 0x0
// Checksum 0x573c1bcc, Offset: 0x6d8
// Size: 0x124
function function_b6f1c993(start, target, time, var_4ca73085, ease_in, ease_out, var_33ce6852) {
    assert(self isplayer());
    assert(target > 0);
    if (!isdefined(start)) {
        start = self function_78bf7752();
    }
    localclientnum = self getlocalclientnumber();
    self thread function_d4a4a726(localclientnum, start, target, time, &function_dd427b21, var_4ca73085, "ease_camera_lens_focal_distance", ["ease_camera_lens_focal_distance", "deactivate_camera_lens_overrides"], ease_in, ease_out, var_33ce6852);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 7, eflags: 0x0
// Checksum 0xfe2ced03, Offset: 0x808
// Size: 0x124
function function_136edb11(start, target, time, var_4ca73085, ease_in, ease_out, var_33ce6852) {
    assert(self isplayer());
    assert(target > 0);
    if (!isdefined(start)) {
        start = self function_28aef982();
    }
    localclientnum = self getlocalclientnumber();
    self thread function_d4a4a726(localclientnum, start, target, time, &function_9f966a98, var_4ca73085, "ease_camera_lens_fstop", ["ease_camera_lens_fstop", "deactivate_camera_lens_overrides"], ease_in, ease_out, var_33ce6852);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 9, eflags: 0x0
// Checksum 0x8e6ad8d2, Offset: 0x938
// Size: 0xb4
function function_86ac55c5(localclientnum, dvar, var_c7ec7d60, value, time, var_4ca73085, ease_in, ease_out, var_33ce6852) {
    self thread function_d4a4a726(localclientnum, getdvarfloat(dvar), value, time, &function_8ff186e5, var_4ca73085, "ease_dvar_" + dvar, "ease_dvar_" + dvar, ease_in, ease_out, var_33ce6852, dvar, var_c7ec7d60);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 9, eflags: 0x0
// Checksum 0xed8b5c4c, Offset: 0x9f8
// Size: 0x194
function ease_origin(localclientnum, target, time, var_4ca73085, axis, additive, ease_in, ease_out, var_33ce6852) {
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
    self thread function_d4a4a726(localclientnum, var_be4baa48, target, time, callback, var_4ca73085, "ease_origin", endons, ease_in, ease_out, var_33ce6852, axis);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 9, eflags: 0x0
// Checksum 0x44c3b534, Offset: 0xb98
// Size: 0x194
function ease_angles(localclientnum, target, time, var_4ca73085, axis, additive, ease_in, ease_out, var_33ce6852) {
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
    self thread function_d4a4a726(localclientnum, var_be4baa48, target, time, callback, var_4ca73085, "ease_angles", endons, ease_in, ease_out, var_33ce6852, axis);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 12, eflags: 0x20 variadic
// Checksum 0xba3a9e31, Offset: 0xd38
// Size: 0x5be
function function_d4a4a726(localclientnum, var_be4baa48, target_value, time, var_f71e2d8f, var_4ca73085 = #"linear", notifies, endons, ease_in, ease_out, var_33ce6852, ...) {
    assert(isdefined(level.var_b649495c));
    assert(isdefined(level.var_b649495c[var_4ca73085]));
    localplayer = function_5c10bd79(localclientnum);
    if (!isdefined(localplayer)) {
        return;
    }
    localplayer endon(#"death");
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
    last_time = float(localplayer getclienttime()) / 1000;
    cur_time = 0;
    while (cur_time < time) {
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
        var_d916543d = float(localplayer getclienttime()) / 1000;
        cur_time += var_d916543d - last_time;
        last_time = var_d916543d;
    }
    var_b3160f0.var_872a88cd = target_value;
    var_b3160f0.delta = var_b3160f0.target_value - var_88a4b08c;
    var_b3160f0.var_37e98bce = 1;
    var_b3160f0.localclientnum = localclientnum;
    util::function_50f54b6f(self, var_f71e2d8f, var_b3160f0, vararg);
    if (isdefined(self)) {
        self notify(#"hash_133229f708f5d10", {#var_be4baa48:var_be4baa48, #target_value:target_value, #time:time, #var_f71e2d8f:var_f71e2d8f, #var_4ca73085:var_4ca73085, #localclientnum:localclientnum});
    }
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 2, eflags: 0x4
// Checksum 0x15725a89, Offset: 0x1300
// Size: 0x34
function private function_3d07aeab(var_b3160f0, ui_model) {
    setuimodelvalue(ui_model, var_b3160f0.var_872a88cd);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 1, eflags: 0x4
// Checksum 0x8f28d3bc, Offset: 0x1340
// Size: 0x2c
function private function_5b854508(var_b3160f0) {
    self camerasetposition(var_b3160f0.var_872a88cd);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 1, eflags: 0x4
// Checksum 0x5180274f, Offset: 0x1378
// Size: 0x2c
function private function_d4923609(var_b3160f0) {
    self camerasetlookat(var_b3160f0.var_872a88cd);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 1, eflags: 0x4
// Checksum 0xca4dd290, Offset: 0x13b0
// Size: 0x4c
function private function_c426caa9(var_b3160f0) {
    self function_49cdf043(max(1e-05, var_b3160f0.var_872a88cd), 0);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 1, eflags: 0x4
// Checksum 0x4566dbcb, Offset: 0x1408
// Size: 0x4c
function private function_dd427b21(var_b3160f0) {
    self function_d7be9a9f(max(1e-05, var_b3160f0.var_872a88cd), 0);
}

// Namespace namespace_ca99987f/namespace_ca99987f
// Params 1, eflags: 0x4
// Checksum 0x24e6cc06, Offset: 0x1460
// Size: 0x4c
function private function_9f966a98(var_b3160f0) {
    self function_1816c600(max(1e-05, var_b3160f0.var_872a88cd), 0);
}

