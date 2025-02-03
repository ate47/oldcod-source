#using scripts\core_common\flowgraph\flowgraph_core;

#namespace flowgraph_logic;

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x58447f8d, Offset: 0x68
// Size: 0x2a
function iffunc(*x, b) {
    return array(b, !b);
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x389b36ff, Offset: 0xa0
// Size: 0x4a
function orfunc(*x, b_a, b_b) {
    return array(b_a || b_b, !(b_a || b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x4a9cd882, Offset: 0xf8
// Size: 0x4a
function andfunc(*x, b_a, b_b) {
    return array(b_a && b_b, !(b_a && b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xcaaba953, Offset: 0x150
// Size: 0x12
function notfunc(b_value) {
    return !b_value;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xf3735a1e, Offset: 0x170
// Size: 0x1a
function lessthan(var_a, var_b) {
    return var_a < var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xc772b13, Offset: 0x198
// Size: 0x1a
function function_b457969e(var_a, var_b) {
    return var_a <= var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xacfb9f0c, Offset: 0x1c0
// Size: 0x1a
function greaterthan(var_a, var_b) {
    return var_a > var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x6e409b98, Offset: 0x1e8
// Size: 0x1a
function function_3743e19e(var_a, var_b) {
    return var_a >= var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xa9dee996, Offset: 0x210
// Size: 0x1a
function equal(var_a, var_b) {
    return var_a == var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xf13afaa4, Offset: 0x238
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
// Checksum 0xc41730ea, Offset: 0x2f0
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
// Checksum 0x187ca613, Offset: 0x410
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
// Checksum 0x4445d261, Offset: 0x588
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
// Checksum 0xd6d7e853, Offset: 0x758
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
// Checksum 0x376d929d, Offset: 0x980
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
// Checksum 0x14f634df, Offset: 0xc38
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
// Checksum 0xe0d675bb, Offset: 0xf50
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
// Checksum 0x8ed1dd5e, Offset: 0xff0
// Size: 0xb0
function foreachloop(*x, a_items) {
    foreach (item in a_items) {
        self flowgraph::kick(array(1, item), 1);
    }
}

// Namespace flowgraph_loops/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xe3caf6e9, Offset: 0x10a8
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
// Checksum 0xf19d1673, Offset: 0x1120
// Size: 0x6c
function sequence2(*x) {
    self flowgraph::kick(array(1, 0), 1);
    self flowgraph::kick(array(0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x1bf9439b, Offset: 0x1198
// Size: 0x9c
function sequence3(*x) {
    self flowgraph::kick(array(1, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x8a958844, Offset: 0x1240
// Size: 0xcc
function sequence4(*x) {
    self flowgraph::kick(array(1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x429243e3, Offset: 0x1318
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
// Checksum 0xc1e48080, Offset: 0x1448
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
// Checksum 0x9e1df191, Offset: 0x15b0
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
// Checksum 0x8811a8f5, Offset: 0x1750
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
// Checksum 0x41d2f30f, Offset: 0x1928
// Size: 0x24
function onflowgraphrun() {
    self.owner waittill(#"flowgraph_run");
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x24552614, Offset: 0x1958
// Size: 0x1e
function waitfunc(*x, f_seconds) {
    wait f_seconds;
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x87bc591a, Offset: 0x1980
// Size: 0x10
function createthread(*x) {
    return true;
}

#namespace flowgraph_random;

// Namespace flowgraph_random/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xdf3968a2, Offset: 0x1998
// Size: 0x2a
function randomfloatinrangefunc(f_min, f_max) {
    return randomfloatrange(f_min, f_max);
}

// Namespace flowgraph_random/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0xcd2864ce, Offset: 0x19d0
// Size: 0x5a
function randomunitvector() {
    return vectornormalize((randomfloat(1), randomfloat(1), randomfloat(1)));
}

#namespace flowgraph_math;

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x26035a85, Offset: 0x1a38
// Size: 0x1a
function multiply(var_1, *var_2) {
    return var_2 * var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x7ba94340, Offset: 0x1a60
// Size: 0x1a
function divide(var_1, var_2) {
    return var_1 / var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x5f7212df, Offset: 0x1a88
// Size: 0x1a
function add(var_1, var_2) {
    return var_1 + var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x7530fb49, Offset: 0x1ab0
// Size: 0x1a
function subtract(var_1, var_2) {
    return var_1 - var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xf3b48b67, Offset: 0x1ad8
// Size: 0x16
function negate(v) {
    return v * -1;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xe37f97e1, Offset: 0x1af8
// Size: 0x2a
function vectordotfunc(v_1, v_2) {
    return vectordot(v_1, v_2);
}

#namespace flowgraph_lighting;

// Namespace flowgraph_lighting/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0x6d483afe, Offset: 0x1b30
// Size: 0x12
function getlightingstatefunc() {
    return getlightingstate();
}

#namespace flowgraph_level;

// Namespace flowgraph_level/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xf6f354b2, Offset: 0x1b50
// Size: 0x18
function function_35dc468d(str_field) {
    return level.(str_field);
}

// Namespace flowgraph_level/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x117ce8bf, Offset: 0x1b70
// Size: 0x32
function function_f9d5c4b0(*x, str_field, var_value) {
    level.(str_field) = var_value;
    return true;
}

#namespace namespace_22752a75;

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xddcb7fd5, Offset: 0x1bb0
// Size: 0x10
function function_8892c7a6(i_value) {
    return i_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xaa44d4e, Offset: 0x1bc8
// Size: 0x10
function function_28c4ae67(f_value) {
    return f_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x7ccb5b53, Offset: 0x1be0
// Size: 0x10
function function_36bf9c6c(b_value) {
    return b_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xc2ce7267, Offset: 0x1bf8
// Size: 0x10
function function_fe4cf085(str_value) {
    return str_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xe09cbd38, Offset: 0x1c10
// Size: 0x10
function function_3ece9d7e(h_value) {
    return h_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xf74cb14, Offset: 0x1c28
// Size: 0x10
function function_68a5d644(ea_value) {
    return ea_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x9123614e, Offset: 0x1c40
// Size: 0x10
function vectorconstant(v_value) {
    return v_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xf57c173f, Offset: 0x1c58
// Size: 0x10
function pathnodeconstant(var_f4af12cc) {
    return var_f4af12cc;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x31b0b379, Offset: 0x1c70
// Size: 0x10
function function_9ef80b8b(e_value) {
    return e_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x64089e4, Offset: 0x1c88
// Size: 0x10
function introduction_minigun(ai_value) {
    return ai_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xf413d8d9, Offset: 0x1ca0
// Size: 0x10
function function_513da14e(var_162b6305) {
    return var_162b6305;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xfe0f8395, Offset: 0x1cb8
// Size: 0x10
function function_7cbb60c3(sp_value) {
    return sp_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x287dc4f1, Offset: 0x1cd0
// Size: 0x10
function function_f2357a4d(w_value) {
    return w_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x84c37602, Offset: 0x1ce8
// Size: 0x10
function function_79f7d941(var_value) {
    return var_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x6e461ef0, Offset: 0x1d00
// Size: 0x10
function function_fdafe394(var_e477c3b) {
    return var_e477c3b;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xcc96c6dd, Offset: 0x1d18
// Size: 0x10
function function_28848a6a(mdl_value) {
    return mdl_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x624b5f09, Offset: 0x1d30
// Size: 0x10
function function_8f5a9b3e(fx_value) {
    return fx_value;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x83c828f4, Offset: 0x1d48
// Size: 0x10
function function_a5f771ce(var_e0bddaf5) {
    return var_e0bddaf5;
}

// Namespace namespace_22752a75/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x4b54b454, Offset: 0x1d60
// Size: 0x10
function function_527fa489(var_5ab747e5) {
    return var_5ab747e5;
}

