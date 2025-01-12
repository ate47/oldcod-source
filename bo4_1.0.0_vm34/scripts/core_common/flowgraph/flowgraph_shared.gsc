#using scripts\core_common\flowgraph\flowgraph_core;

#namespace flowgraph_logic;

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x620bbc66, Offset: 0x70
// Size: 0x2a
function iffunc(x, b) {
    return array(b, !b);
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xf62b6f42, Offset: 0xa8
// Size: 0x4a
function orfunc(x, b_a, b_b) {
    return array(b_a || b_b, !(b_a || b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x7a3e75f4, Offset: 0x100
// Size: 0x4a
function andfunc(x, b_a, b_b) {
    return array(b_a && b_b, !(b_a && b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x7adc8c8a, Offset: 0x158
// Size: 0x12
function notfunc(b_value) {
    return !b_value;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x9b3c7f4d, Offset: 0x178
// Size: 0x1e
function lessthan(var_a, var_b) {
    return var_a < var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xa6f5b90c, Offset: 0x1a0
// Size: 0x1e
function function_5e3e5f18(var_a, var_b) {
    return var_a <= var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xd0635798, Offset: 0x1c8
// Size: 0x1e
function greaterthan(var_a, var_b) {
    return var_a > var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x63f8eb2c, Offset: 0x1f0
// Size: 0x1e
function function_66db6061(var_a, var_b) {
    return var_a >= var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xcdb8d871, Offset: 0x218
// Size: 0x1e
function equal(var_a, var_b) {
    return var_a == var_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x97e630fd, Offset: 0x240
// Size: 0xa4
function function_fc95d295(x, b_1, b_2) {
    if (isdefined(b_1) && b_1) {
        self flowgraph::kick(array(undefined, 1, 0), 1);
        return;
    }
    if (isdefined(b_2) && b_2) {
        self flowgraph::kick(array(undefined, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 4, eflags: 0x0
// Checksum 0x25667632, Offset: 0x2f0
// Size: 0xfc
function function_d693582c(x, b_1, b_2, b_3) {
    if (isdefined(b_1) && b_1) {
        self flowgraph::kick(array(undefined, 1, 0, 0), 1);
        return;
    }
    if (isdefined(b_2) && b_2) {
        self flowgraph::kick(array(undefined, 0, 1, 0), 1);
        return;
    }
    if (isdefined(b_3) && b_3) {
        self flowgraph::kick(array(undefined, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 5, eflags: 0x0
// Checksum 0x4cf6ad9e, Offset: 0x3f8
// Size: 0x14c
function function_b090ddc3(x, b_1, b_2, b_3, b_4) {
    if (isdefined(b_1) && b_1) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_2) && b_2) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0), 1);
        return;
    }
    if (isdefined(b_3) && b_3) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0), 1);
        return;
    }
    if (isdefined(b_4) && b_4) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 6, eflags: 0x0
// Checksum 0xd4c0240e, Offset: 0x550
// Size: 0x1bc
function function_8a8e635a(x, b_1, b_2, b_3, b_4, b_5) {
    if (isdefined(b_1) && b_1) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_2) && b_2) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_3) && b_3) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0), 1);
        return;
    }
    if (isdefined(b_4) && b_4) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0), 1);
        return;
    }
    if (isdefined(b_5) && b_5) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 7, eflags: 0x0
// Checksum 0x719efdd8, Offset: 0x718
// Size: 0x214
function function_648be8f1(x, b_1, b_2, b_3, b_4, b_5, b_6) {
    if (isdefined(b_1) && b_1) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_2) && b_2) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_3) && b_3) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_4) && b_4) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0), 1);
        return;
    }
    if (isdefined(b_5) && b_5) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0), 1);
        return;
    }
    if (isdefined(b_6) && b_6) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 8, eflags: 0x0
// Checksum 0x4ce83b9a, Offset: 0x938
// Size: 0x274
function function_3e896e88(x, b_1, b_2, b_3, b_4, b_5, b_6, b_7) {
    if (isdefined(b_1) && b_1) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_2) && b_2) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_3) && b_3) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_4) && b_4) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_5) && b_5) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0, 0), 1);
        return;
    }
    if (isdefined(b_6) && b_6) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1, 0), 1);
        return;
    }
    if (isdefined(b_7) && b_7) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 1), 1);
    }
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 9, eflags: 0x0
// Checksum 0xe962f1b1, Offset: 0xbb8
// Size: 0x2cc
function function_1886f41f(x, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8) {
    if (isdefined(b_1) && b_1) {
        self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_2) && b_2) {
        self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_3) && b_3) {
        self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_4) && b_4) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_5) && b_5) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0, 0, 0), 1);
        return;
    }
    if (isdefined(b_6) && b_6) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1, 0, 0), 1);
        return;
    }
    if (isdefined(b_7) && b_7) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 1, 0), 1);
        return;
    }
    if (isdefined(b_8) && b_8) {
        self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 0, 1), 1);
    }
}

#namespace flowgraph_loops;

// Namespace flowgraph_loops/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xaa11a5b1, Offset: 0xe90
// Size: 0x9e
function forloop(x, i_begin, i_end) {
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
// Checksum 0xa77cac72, Offset: 0xf38
// Size: 0xa0
function foreachloop(x, a_items) {
    foreach (item in a_items) {
        self flowgraph::kick(array(1, item), 1);
    }
}

// Namespace flowgraph_loops/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x4f4e969c, Offset: 0xfe0
// Size: 0x70
function whileloop(x, b_condition) {
    while (b_condition) {
        self flowgraph::kick(1, 1);
        inputs = self flowgraph::collect_inputs();
        b_condition = inputs[1];
    }
}

#namespace flowgraph_sequence;

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x4fa0948, Offset: 0x1058
// Size: 0x6c
function sequence2(x) {
    self flowgraph::kick(array(1, 0), 1);
    self flowgraph::kick(array(0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xd7e9d76, Offset: 0x10d0
// Size: 0x9c
function sequence3(x) {
    self flowgraph::kick(array(1, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xabd68dc3, Offset: 0x1178
// Size: 0xcc
function sequence4(x) {
    self flowgraph::kick(array(1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xd5ce9c34, Offset: 0x1250
// Size: 0x124
function sequence5(x) {
    self flowgraph::kick(array(1, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x70557ee9, Offset: 0x1380
// Size: 0x15c
function sequence6(x) {
    self flowgraph::kick(array(1, 0, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x5477fb09, Offset: 0x14e8
// Size: 0x194
function sequence7(x) {
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
// Checksum 0xf16b0ea0, Offset: 0x1688
// Size: 0x1cc
function sequence8(x) {
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
// Checksum 0xf0ae288d, Offset: 0x1860
// Size: 0x24
function onflowgraphrun() {
    self.owner waittill(#"flowgraph_run");
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x3ccec312, Offset: 0x1890
// Size: 0x1e
function waitfunc(x, f_seconds) {
    wait f_seconds;
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x328dac87, Offset: 0x18b8
// Size: 0x10
function createthread(x) {
    return true;
}

#namespace flowgraph_random;

// Namespace flowgraph_random/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x411cbd0e, Offset: 0x18d0
// Size: 0x2a
function randomfloatinrangefunc(f_min, f_max) {
    return randomfloatrange(f_min, f_max);
}

// Namespace flowgraph_random/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0x348b0e9, Offset: 0x1908
// Size: 0x5a
function randomunitvector() {
    return vectornormalize((randomfloat(1), randomfloat(1), randomfloat(1)));
}

#namespace flowgraph_math;

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x5358daa1, Offset: 0x1970
// Size: 0x1e
function multiply(var_1, var_2) {
    return var_1 * var_1;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x73535df3, Offset: 0x1998
// Size: 0x1e
function divide(var_1, var_2) {
    return var_1 / var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x845f0c4e, Offset: 0x19c0
// Size: 0x1e
function add(var_1, var_2) {
    return var_1 + var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x222f7dca, Offset: 0x19e8
// Size: 0x1e
function subtract(var_1, var_2) {
    return var_1 - var_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xbf0dd0f0, Offset: 0x1a10
// Size: 0x16
function negate(v) {
    return v * -1;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x5d7bd85c, Offset: 0x1a30
// Size: 0x2a
function vectordotfunc(v_1, v_2) {
    return vectordot(v_1, v_2);
}

#namespace flowgraph_level;

// Namespace flowgraph_level/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xa9797bd9, Offset: 0x1a68
// Size: 0x18
function function_9cf66891(str_field) {
    return level.(str_field);
}

// Namespace flowgraph_level/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x7f7ac7eb, Offset: 0x1a88
// Size: 0x32
function function_bbee000d(x, str_field, var_value) {
    level.(str_field) = var_value;
    return true;
}

#namespace namespace_cd7df369;

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xd8a76a60, Offset: 0x1ac8
// Size: 0x10
function function_20946d5c(i_value) {
    return i_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xc924369f, Offset: 0x1ae0
// Size: 0x10
function function_b689929d(f_value) {
    return f_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x8ac7f5dd, Offset: 0x1af8
// Size: 0x10
function function_b2332eed(b_value) {
    return b_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x7e7325eb, Offset: 0x1b10
// Size: 0x10
function function_c3bd977e(str_value) {
    return str_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xe7690bd3, Offset: 0x1b28
// Size: 0x10
function function_415283b1(h_value) {
    return h_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x488482a6, Offset: 0x1b40
// Size: 0x10
function function_4083d92f(ea_value) {
    return ea_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x7a54f495, Offset: 0x1b58
// Size: 0x10
function vectorconstant(v_value) {
    return v_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x948426c5, Offset: 0x1b70
// Size: 0x10
function pathnodeconstant(var_b7106cad) {
    return var_b7106cad;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x7ab3a86e, Offset: 0x1b88
// Size: 0x10
function function_917bb534(e_value) {
    return e_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xbf171b7f, Offset: 0x1ba0
// Size: 0x10
function function_a8ed99f3(ai_value) {
    return ai_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xd63d0b7, Offset: 0x1bb8
// Size: 0x10
function function_5170916f(var_15acc331) {
    return var_15acc331;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xaeef11bc, Offset: 0x1bd0
// Size: 0x10
function function_3b505d57(sp_value) {
    return sp_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xcdb55aa7, Offset: 0x1be8
// Size: 0x10
function function_fb55c021(w_value) {
    return w_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x6278cc66, Offset: 0x1c00
// Size: 0x10
function function_7cc5ff1c(var_value) {
    return var_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xf9f1199d, Offset: 0x1c18
// Size: 0x10
function function_635e27c(var_af385c18) {
    return var_af385c18;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x5b5edd15, Offset: 0x1c30
// Size: 0x10
function function_7328276e(mdl_value) {
    return mdl_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x5a75a123, Offset: 0x1c48
// Size: 0x10
function function_5b4bf183(fx_value) {
    return fx_value;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x66b1efab, Offset: 0x1c60
// Size: 0x10
function function_6f8d576c(var_88bde1f4) {
    return var_88bde1f4;
}

// Namespace namespace_cd7df369/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x550db0e7, Offset: 0x1c78
// Size: 0x10
function function_53d8f936(var_5e6ac690) {
    return var_5e6ac690;
}

