#using scripts\core_common\flowgraph\flowgraph_core;

#namespace flowgraph_logic;

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x332e5d30, Offset: 0x68
// Size: 0x2a
function iffunc(*x, b) {
    return array(b, !b);
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xd73fbadf, Offset: 0xa0
// Size: 0x4a
function orfunc(*x, b_a, b_b) {
    return array(b_a || b_b, !(b_a || b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xf8de6dd3, Offset: 0xf8
// Size: 0x4a
function andfunc(*x, b_a, b_b) {
    return array(b_a && b_b, !(b_a && b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x2a67e0d3, Offset: 0x150
// Size: 0x12
function notfunc(b_value) {
    return !b_value;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x827830f9, Offset: 0x170
// Size: 0x1a
function lessthan(var_a, var_b) {
    return var_a < var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x1c3c4818, Offset: 0x198
// Size: 0x1a
function function_b457969e(var_a, var_b) {
    return var_a <= var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xf6aaf10b, Offset: 0x1c0
// Size: 0x1a
function greaterthan(var_a, var_b) {
    return var_a > var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xd2a54154, Offset: 0x1e8
// Size: 0x1a
function function_3743e19e(var_a, var_b) {
    return var_a >= var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xfd58039c, Offset: 0x210
// Size: 0x1a
function equal(var_a, var_b) {
    return var_a == var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xc262c4d2, Offset: 0x238
// Size: 0xac
function function_5cb6d7c8(*x, b_1, b_2) {
    if (is_true(b_1)) {
        self flowgraph::kick(array(undefined, 1, 0), 1);
        return;
    }
    if (is_true(b_2)) {
        self flowgraph::kick(array(undefined, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 4, eflags: 0x0
// Checksum 0xc34b8bee, Offset: 0x2f0
// Size: 0x114
function function_4902305f(*x, b_1, b_2, b_3) {
    if (is_true(b_1)) {
        self flowgraph::kick(array(undefined, 1, 0, 0), 1);
        return;
    }
    if (is_true(b_2)) {
        self flowgraph::kick(array(undefined, 0, 1, 0), 1);
        return;
    }
    if (is_true(b_3)) {
        self flowgraph::kick(array(undefined, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 5, eflags: 0x0
// Checksum 0x14426e00, Offset: 0x410
// Size: 0x16c
function function_3b225c4(*x, b_1, b_2, b_3, b_4) {
    if (is_true(b_1)) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_2)) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0), 1);
        return;
    }
    if (is_true(b_3)) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0), 1);
        return;
    }
    if (is_true(b_4)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 6, eflags: 0x0
// Checksum 0xc5e65810, Offset: 0x588
// Size: 0x1c4
function function_f82f0ebe(*x, b_1, b_2, b_3, b_4, b_5) {
    if (is_true(b_1)) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_2)) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_3)) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0), 1);
        return;
    }
    if (is_true(b_4)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0), 1);
        return;
    }
    if (is_true(b_5)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 7, eflags: 0x0
// Checksum 0xd360f10c, Offset: 0x758
// Size: 0x21c
function function_3f431ce5(*x, b_1, b_2, b_3, b_4, b_5, b_6) {
    if (is_true(b_1)) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_2)) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_3)) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_4)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0), 1);
        return;
    }
    if (is_true(b_5)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0), 1);
        return;
    }
    if (is_true(b_6)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 8, eflags: 0x0
// Checksum 0x38a8f3e4, Offset: 0x980
// Size: 0x2ac
function function_2d817962(*x, b_1, b_2, b_3, b_4, b_5, b_6, b_7) {
    if (is_true(b_1)) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_2)) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_3)) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_4)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_5)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0, 0), 1);
        return;
    }
    if (is_true(b_6)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1, 0), 1);
        return;
    }
    if (is_true(b_7)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 9, eflags: 0x0
// Checksum 0xbe86c5d4, Offset: 0xc38
// Size: 0x30c
function function_c8fcb052(*x, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8) {
    if (is_true(b_1)) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_2)) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_3)) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_4)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_5)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0, 0, 0), 1);
        return;
    }
    if (is_true(b_6)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1, 0, 0), 1);
        return;
    }
    if (is_true(b_7)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 1, 0), 1);
        return;
    }
    if (is_true(b_8)) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 0, 1), 1);
    }
}

#namespace flowgraph_loops;

// Namespace flowgraph_loops/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xe14f874f, Offset: 0xf50
// Size: 0x92
function forloop(*x, i_begin, i_end) {
    i_step = 1;
    if (i_end < i_begin) {
        i_step = -1;
    }
    for (i = i_begin; i != i_end; i += i_step) {
        self flowgraph::kick(array(1, i), 1);
    }
}

// Namespace flowgraph_loops/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x706d7097, Offset: 0xff0
// Size: 0xb0
function foreachloop(*x, a_items) {
    foreach (item in a_items) {
        self flowgraph::kick(array(1, item), 1);
    }
}

// Namespace flowgraph_loops/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xbfbd4f62, Offset: 0x10a8
// Size: 0x6e
function whileloop(*x, b_condition) {
    while (b_condition) {
        self flowgraph::kick(1, 1);
        inputs = self flowgraph::collect_inputs();
        b_condition = inputs[1];
    }
}

#namespace flowgraph_sequence;

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x671cd317, Offset: 0x1120
// Size: 0x6c
function sequence2(*x) {
    self flowgraph::kick(array(1, 0), 1);
    self flowgraph::kick(array(0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x4d66120d, Offset: 0x1198
// Size: 0x9c
function sequence3(*x) {
    self flowgraph::kick(array(1, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x67d2cad8, Offset: 0x1240
// Size: 0xcc
function sequence4(*x) {
    self flowgraph::kick(array(1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x5b3dd3af, Offset: 0x1318
// Size: 0x124
function sequence5(*x) {
    self flowgraph::kick(array(1, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x4f24b023, Offset: 0x1448
// Size: 0x15c
function sequence6(*x) {
    self flowgraph::kick(array(1, 0, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x58250f4d, Offset: 0x15b0
// Size: 0x194
function sequence7(*x) {
    self flowgraph::kick(array(1, 0, 0, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xd03b6e2, Offset: 0x1750
// Size: 0x1cc
function sequence8(*x) {
    self flowgraph::kick(array(1, 0, 0, 0, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 0, 1), 1);
}

#namespace flowgraph_util;

// Namespace flowgraph_util/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0xe21772ef, Offset: 0x1928
// Size: 0x24
function onflowgraphrun() {
    self.owner waittill(#"flowgraph_run");
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x92bd8512, Offset: 0x1958
// Size: 0x1e
function waitfunc(*x, f_seconds) {
    wait f_seconds;
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xb63dca6, Offset: 0x1980
// Size: 0x10
function createthread(*x) {
    return true;
}

#namespace flowgraph_random;

// Namespace flowgraph_random/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x6bc52c9b, Offset: 0x1998
// Size: 0x2a
function randomfloatinrangefunc(f_min, f_max) {
    return randomfloatrange(f_min, f_max);
}

// Namespace flowgraph_random/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0x8eee1fde, Offset: 0x19d0
// Size: 0x5a
function randomunitvector() {
    return vectornormalize((randomfloat(1), randomfloat(1), randomfloat(1)));
}

#namespace flowgraph_math;

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xbd3c4fd9, Offset: 0x1a38
// Size: 0x1a
function multiply(var_1, *var_2) {
    return var_2 * var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x4e666d78, Offset: 0x1a60
// Size: 0x1a
function divide(var_1, var_2) {
    return var_1 / var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x77355ee7, Offset: 0x1a88
// Size: 0x1a
function add(var_1, var_2) {
    return var_1 + var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xe3bc7bf9, Offset: 0x1ab0
// Size: 0x1a
function subtract(var_1, var_2) {
    return var_1 - var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x4901dd68, Offset: 0x1ad8
// Size: 0x16
function negate(v) {
    return v * -1;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xc1d7f184, Offset: 0x1af8
// Size: 0x2a
function vectordotfunc(v_1, v_2) {
    return vectordot(v_1, v_2);
}

#namespace flowgraph_level;

// Namespace flowgraph_level/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x32ac7775, Offset: 0x1b30
// Size: 0x18
function function_35dc468d(str_field) {
    return level.(str_field);
}

// Namespace flowgraph_level/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x4353365e, Offset: 0x1b50
// Size: 0x32
function function_f9d5c4b0(*x, str_field, var_value) {
    level.(str_field) = var_value;
    return true;
}

#namespace namespace_22752a75;

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x69e94f19, Offset: 0x1b90
// Size: 0x10
function function_8892c7a6(i_value) {
    return i_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xe1f3e246, Offset: 0x1ba8
// Size: 0x10
function function_28c4ae67(var_2eb63fd3) {
    return var_2eb63fd3;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x1bdeb917, Offset: 0x1bc0
// Size: 0x10
function function_36bf9c6c(b_value) {
    return b_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x5c76017a, Offset: 0x1bd8
// Size: 0x10
function function_fe4cf085(str_value) {
    return str_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xd0cc4b85, Offset: 0x1bf0
// Size: 0x10
function function_3ece9d7e(var_4cb0cd3c) {
    return var_4cb0cd3c;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x214ce181, Offset: 0x1c08
// Size: 0x10
function function_68a5d644(var_30e9e231) {
    return var_30e9e231;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x1dfed930, Offset: 0x1c20
// Size: 0x10
function vectorconstant(v_value) {
    return v_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xa9d7ec0d, Offset: 0x1c38
// Size: 0x10
function pathnodeconstant(var_f4af12cc) {
    return var_f4af12cc;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xcdd2e53d, Offset: 0x1c50
// Size: 0x10
function function_9ef80b8b(e_value) {
    return e_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x60b50365, Offset: 0x1c68
// Size: 0x10
function introduction_minigun(ai_value) {
    return ai_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x5af3fab8, Offset: 0x1c80
// Size: 0x10
function function_513da14e(var_162b6305) {
    return var_162b6305;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x2878cbb9, Offset: 0x1c98
// Size: 0x10
function function_7cbb60c3(var_e7355b57) {
    return var_e7355b57;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xfcb39098, Offset: 0x1cb0
// Size: 0x10
function function_f2357a4d(var_52d6c2bd) {
    return var_52d6c2bd;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x2e0211d, Offset: 0x1cc8
// Size: 0x10
function function_79f7d941(var_value) {
    return var_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x7d4f75c3, Offset: 0x1ce0
// Size: 0x10
function function_fdafe394(var_e477c3b) {
    return var_e477c3b;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x88aed390, Offset: 0x1cf8
// Size: 0x10
function function_28848a6a(var_6b11d5a) {
    return var_6b11d5a;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x8ef42ece, Offset: 0x1d10
// Size: 0x10
function function_8f5a9b3e(fx_value) {
    return fx_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x229943ac, Offset: 0x1d28
// Size: 0x10
function function_a5f771ce(var_e0bddaf5) {
    return var_e0bddaf5;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xfe4c90f7, Offset: 0x1d40
// Size: 0x10
function function_527fa489(var_5ab747e5) {
    return var_5ab747e5;
}

