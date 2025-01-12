#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;

#namespace cinematicmotion;

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x6
// Checksum 0x65f5ff5d, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"cinematicmotion", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 1, eflags: 0x1 linked
// Checksum 0x20e45979, Offset: 0x100
// Size: 0x74
function function_70a657d8(*localclientnum) {
    n_bits = getminbitcountfornum(11);
    clientfield::register("toplayer", "cinematicMotion", 1, n_bits, "int", &function_877ad7c4, 0, 1);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 7, eflags: 0x1 linked
// Checksum 0x7b620e24, Offset: 0x180
// Size: 0x5c
function function_877ad7c4(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (fieldname != bwastimejump) {
        self function_c64b5405(bwastimejump);
    }
}

// Namespace cinematicmotion/namespace_345fff71
// Params 1, eflags: 0x1 linked
// Checksum 0xf4a47526, Offset: 0x1e8
// Size: 0x23a
function function_c64b5405(newval) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    switch (newval) {
    case 0:
        self function_eadd0084();
        break;
    case 1:
        self function_7aa6104();
        break;
    case 2:
        self function_19690481();
        break;
    case 3:
        self function_7f56196();
        break;
    case 4:
        self function_19a404f3();
        break;
    case 5:
        self function_f27b36a2();
        break;
    case 6:
        self function_4887c796();
        break;
    case 7:
        self function_22441ab3();
        break;
    case 8:
        self function_5a740afe();
        break;
    case 9:
        self function_681e2652();
        break;
    case 10:
        self function_bd015017();
        break;
    case 11:
        self function_ccb26f79();
        break;
    default:
        break;
    }
}

// Namespace cinematicmotion/namespace_345fff71
// Params 1, eflags: 0x1 linked
// Checksum 0x7eab3016, Offset: 0x430
// Size: 0x64
function function_8152b11(param) {
    if (!self function_21c0fa55()) {
        return;
    }
    if (param != "") {
        self setcinematicmotionoverride(param);
        return;
    }
    self setcinematicmotionoverride();
}

// Namespace cinematicmotion/namespace_345fff71
// Params 2, eflags: 0x1 linked
// Checksum 0xa430f586, Offset: 0x4a0
// Size: 0x10c
function function_bd8097ae(duration, endval) {
    if (!self function_21c0fa55()) {
        return;
    }
    if (!isdefined(endval)) {
        return;
    }
    var_9a52780d = float(endval);
    if (isdefined(duration)) {
        var_48f70e07 = float(duration);
    }
    if (!isdefined(var_48f70e07)) {
        var_48f70e07 = 0;
    }
    if (!isdefined(var_9a52780d)) {
        var_9a52780d = 0;
    }
    if (var_48f70e07 > 0) {
        var_6f465937 = self function_d40e85f();
        self function_6757d9a1(var_6f465937, var_9a52780d, var_48f70e07);
        return;
    }
    self function_97c2dab8(var_9a52780d);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 3, eflags: 0x1 linked
// Checksum 0x5055230f, Offset: 0x5b8
// Size: 0x152
function function_6757d9a1(startval, endval, duration) {
    self notify("571c05ff9137e8da");
    self endon("571c05ff9137e8da");
    self endon(#"death_or_disconnect");
    currenttime = gettime();
    duration *= 1000;
    endtime = int(currenttime + duration);
    diff = abs(startval - endval);
    while (true) {
        currenttime = gettime();
        t = math::clamp(1 - (endtime - currenttime) / duration, 0, 1);
        frac = lerpfloat(startval, endval, t);
        self function_97c2dab8(frac);
        if (t == 1) {
            break;
        }
        waitframe(1);
    }
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0x1797d38b, Offset: 0x718
// Size: 0x24
function function_4887c796() {
    self function_97c2dab8(1);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0x74f3deb4, Offset: 0x748
// Size: 0x34
function function_22441ab3() {
    self thread function_6757d9a1(0, 1, 1);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0x25e89a4a, Offset: 0x788
// Size: 0x34
function function_5a740afe() {
    self thread function_6757d9a1(0, 1, 2);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0x39d302fa, Offset: 0x7c8
// Size: 0x34
function function_681e2652() {
    self thread function_6757d9a1(0, 1, 3);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0xd5c7d814, Offset: 0x808
// Size: 0x34
function function_bd015017() {
    self thread function_6757d9a1(0, 1, 4);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0xd925951e, Offset: 0x848
// Size: 0x34
function function_ccb26f79() {
    self thread function_6757d9a1(0, 1, 5);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0xe3caa194, Offset: 0x888
// Size: 0x24
function function_eadd0084() {
    self function_97c2dab8(0);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0xe9fe9243, Offset: 0x8b8
// Size: 0x34
function function_7aa6104() {
    self thread function_6757d9a1(1, 0, 1);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0x9ae1b7e5, Offset: 0x8f8
// Size: 0x34
function function_19690481() {
    self thread function_6757d9a1(1, 0, 2);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0xe660fed9, Offset: 0x938
// Size: 0x34
function function_7f56196() {
    self thread function_6757d9a1(1, 0, 3);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0x488fb5aa, Offset: 0x978
// Size: 0x34
function function_19a404f3() {
    self thread function_6757d9a1(1, 0, 4);
}

// Namespace cinematicmotion/namespace_345fff71
// Params 0, eflags: 0x1 linked
// Checksum 0xc3346d5, Offset: 0x9b8
// Size: 0x34
function function_f27b36a2() {
    self thread function_6757d9a1(1, 0, 5);
}
