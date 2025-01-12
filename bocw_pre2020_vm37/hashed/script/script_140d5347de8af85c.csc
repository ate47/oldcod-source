#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_ca99987f;

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 0, eflags: 0x6
// Checksum 0xe6b52751, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_1550b2b6cdd56be8", &function_810d6d3a, undefined, undefined, undefined);
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 0, eflags: 0x0
// Checksum 0x7393520, Offset: 0xc0
// Size: 0x1ec
function function_810d6d3a() {
    level.var_b649495c = [];
    level.var_b649495c[#"linear"] = &function_a9f5c57d;
    level.var_b649495c[#"power"] = &function_492ef475;
    level.var_b649495c[#"quadratic"] = &function_db98dad1;
    level.var_b649495c[#"cubic"] = &function_237ad8ca;
    level.var_b649495c[#"quartic"] = &function_79315b1d;
    level.var_b649495c[#"quintic"] = &function_858ecd2d;
    level.var_b649495c[#"exponential"] = &function_95a842a;
    level.var_b649495c[#"logarithmic"] = &function_eec2a804;
    level.var_b649495c[#"sine"] = &function_aab5c503;
    level.var_b649495c[#"back"] = &function_da7df29;
    level.var_b649495c[#"elastic"] = &function_d912ff48;
    level.var_b649495c[#"bounce"] = &function_6aeb681d;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 5, eflags: 0x0
// Checksum 0xaf2dbf16, Offset: 0x2b8
// Size: 0x46
function function_a9f5c57d(start, end, var_600ff81f, *ease_in, *ease_out) {
    return (1 - ease_out) * var_600ff81f + ease_out * ease_in;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 6, eflags: 0x0
// Checksum 0x2c39d726, Offset: 0x308
// Size: 0x72
function function_492ef475(start, end, var_600ff81f, ease_in, ease_out, power) {
    var_600ff81f = easepower(var_600ff81f, power, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 5, eflags: 0x0
// Checksum 0x52c3dda9, Offset: 0x388
// Size: 0x6a
function function_db98dad1(start, end, var_600ff81f, ease_in, ease_out) {
    var_600ff81f = easepower(var_600ff81f, 2, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 5, eflags: 0x0
// Checksum 0x2b81f3d9, Offset: 0x400
// Size: 0x6a
function function_237ad8ca(start, end, var_600ff81f, ease_in, ease_out) {
    var_600ff81f = easepower(var_600ff81f, 3, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 5, eflags: 0x0
// Checksum 0xa0427bf4, Offset: 0x478
// Size: 0x6a
function function_79315b1d(start, end, var_600ff81f, ease_in, ease_out) {
    var_600ff81f = easepower(var_600ff81f, 4, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 5, eflags: 0x0
// Checksum 0x1e608c46, Offset: 0x4f0
// Size: 0x6a
function function_858ecd2d(start, end, var_600ff81f, ease_in, ease_out) {
    var_600ff81f = easepower(var_600ff81f, 5, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 6, eflags: 0x0
// Checksum 0xaaa08a05, Offset: 0x568
// Size: 0x72
function function_95a842a(start, end, var_600ff81f, ease_in, ease_out, scale) {
    var_600ff81f = easeexponential(var_600ff81f, scale, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 6, eflags: 0x0
// Checksum 0x71a02f06, Offset: 0x5e8
// Size: 0x72
function function_eec2a804(start, end, var_600ff81f, ease_in, ease_out, var_18da63b) {
    var_600ff81f = easelogarithmic(var_600ff81f, var_18da63b, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 5, eflags: 0x0
// Checksum 0xa0638f9e, Offset: 0x668
// Size: 0x62
function function_aab5c503(start, end, var_600ff81f, ease_in, ease_out) {
    var_600ff81f = easesine(var_600ff81f, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 7, eflags: 0x0
// Checksum 0x2cf57ddc, Offset: 0x6d8
// Size: 0x7a
function function_da7df29(start, end, var_600ff81f, ease_in, ease_out, var_2d741986, power) {
    var_600ff81f = easeback(var_600ff81f, var_2d741986, power, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 8, eflags: 0x0
// Checksum 0xa1258e3e, Offset: 0x760
// Size: 0x82
function function_d912ff48(start, end, var_600ff81f, ease_in, ease_out, amplitude, frequency, var_6fe616d0) {
    var_600ff81f = easeelastic(var_600ff81f, amplitude, frequency, var_6fe616d0, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 7, eflags: 0x0
// Checksum 0xccbe0c35, Offset: 0x7f0
// Size: 0x7a
function function_6aeb681d(start, end, var_600ff81f, ease_in, ease_out, bounces, var_574c3289) {
    var_600ff81f = easebounce(var_600ff81f, bounces, var_574c3289, ease_in, ease_out);
    return (1 - var_600ff81f) * start + var_600ff81f * end;
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 3, eflags: 0x0
// Checksum 0x1eef6733, Offset: 0x878
// Size: 0x74
function function_8ff186e5(var_b3160f0, dvar, var_c7ec7d60) {
    if (is_true(var_c7ec7d60)) {
        setsaveddvar(dvar, var_b3160f0.var_872a88cd);
        return;
    }
    setdvar(dvar, var_b3160f0.var_872a88cd);
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 2, eflags: 0x0
// Checksum 0x8264d34f, Offset: 0x8f8
// Size: 0x112
function function_54354e4e(var_b3160f0, axis) {
    switch (axis) {
    case 0:
        self.origin = (var_b3160f0.var_872a88cd, self.origin[1], self.origin[2]);
        break;
    case 1:
        self.origin = (self.origin[0], var_b3160f0.var_872a88cd, self.origin[2]);
        break;
    case 2:
        self.origin = (self.origin[0], self.origin[1], var_b3160f0.var_872a88cd);
        break;
    default:
        self.origin = var_b3160f0.var_872a88cd;
        break;
    }
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 2, eflags: 0x0
// Checksum 0x397eff90, Offset: 0xa18
// Size: 0xfa
function function_92b063ff(var_b3160f0, axis) {
    switch (axis) {
    case 0:
        self.origin += (var_b3160f0.delta, 0, 0);
        break;
    case 1:
        self.origin += (0, var_b3160f0.delta, 0);
        break;
    case 2:
        self.origin += (0, 0, var_b3160f0.delta);
        break;
    default:
        self.origin += var_b3160f0.delta;
        break;
    }
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 2, eflags: 0x0
// Checksum 0x3bee00c2, Offset: 0xb20
// Size: 0xd4
function function_3b3f9801(var_b3160f0, axis) {
    var_cad5b24d = 0.016;
    angles = var_b3160f0.var_872a88cd;
    switch (axis) {
    case 0:
        angles = (angles, 0, 0);
        break;
    case 1:
        angles = (0, angles, 0);
        break;
    case 2:
        angles = (0, 0, angles);
        break;
    }
    self rotateto(var_b3160f0.var_872a88cd, var_cad5b24d);
}

// Namespace namespace_ca99987f/namespace_df0c90a5
// Params 2, eflags: 0x0
// Checksum 0xd7c164a6, Offset: 0xc00
// Size: 0x16e
function function_faea843b(var_b3160f0, axis) {
    switch (axis) {
    case 0:
        self.angles += (var_b3160f0.delta, 0, 0);
        break;
    case 1:
        self.angles += (0, var_b3160f0.delta, 0);
        break;
    case 2:
        self.angles += (0, 0, var_b3160f0.delta);
        break;
    default:
        self.angles += var_b3160f0.delta;
        break;
    }
    if (var_b3160f0.var_37e98bce) {
        self.angles = (angleclamp180(self.angles[0]), angleclamp180(self.angles[1]), angleclamp180(self.angles[2]));
    }
}

