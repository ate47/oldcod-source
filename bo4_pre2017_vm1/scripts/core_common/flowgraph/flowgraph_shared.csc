#using scripts/core_common/flag_shared;
#using scripts/core_common/flowgraph/flowgraph_core;
#using scripts/core_common/scene_shared;
#using scripts/core_common/util_shared;

#namespace flowgraph_logic;

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x7c70d986, Offset: 0x150
// Size: 0x32
function iffunc(x, b) {
    return array(b, !b);
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x2c535806, Offset: 0x190
// Size: 0x4a
function orfunc(x, b_a, b_b) {
    return array(b_a || b_b, !(b_a || b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x858a6e2e, Offset: 0x1e8
// Size: 0x4a
function andfunc(x, b_a, b_b) {
    return array(b_a && b_b, !(b_a && b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x36198237, Offset: 0x240
// Size: 0x12
function notfunc(b_value) {
    return !b_value;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x6119768e, Offset: 0x260
// Size: 0x1e
function integerlessthan(i_a, i_b) {
    return i_a < i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xcc11d9a8, Offset: 0x288
// Size: 0x1e
function integerlessthanorequal(i_a, i_b) {
    return i_a <= i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x9dcc3d61, Offset: 0x2b0
// Size: 0x1e
function integergreaterthan(i_a, i_b) {
    return i_a > i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x1954337d, Offset: 0x2d8
// Size: 0x1e
function integergreaterthanorequal(i_a, i_b) {
    return i_a >= i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x2b87af61, Offset: 0x300
// Size: 0x1e
function integersequals(i_a, i_b) {
    return i_a == i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xa004e681, Offset: 0x328
// Size: 0x1e
function floatlessthan(f_a, f_b) {
    return f_a < f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x76625db9, Offset: 0x350
// Size: 0x1e
function floatlessthanorequal(f_a, f_b) {
    return f_a <= f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xfeb8d188, Offset: 0x378
// Size: 0x1e
function floatgreaterthan(f_a, f_b) {
    return f_a > f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x6665f43e, Offset: 0x3a0
// Size: 0x1e
function floatgreaterthanorequal(f_a, f_b) {
    return f_a >= f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x1cee003b, Offset: 0x3c8
// Size: 0x1e
function floatsequal(f_a, f_b) {
    return f_a == f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xcaec4638, Offset: 0x3f0
// Size: 0x1e
function stringsequal(str_a, str_b) {
    return str_a == str_b;
}

#namespace flowgraph_loops;

// Namespace flowgraph_loops/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xcde457f1, Offset: 0x418
// Size: 0xa8
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
// Checksum 0xf67c0654, Offset: 0x4c8
// Size: 0xb2
function foreachloop(x, a_items) {
    foreach (item in a_items) {
        self flowgraph::kick(array(1, item), 1);
    }
}

// Namespace flowgraph_loops/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x2865ba33, Offset: 0x588
// Size: 0x74
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
// Checksum 0x7e25ea2c, Offset: 0x608
// Size: 0x6c
function sequence2(x) {
    self flowgraph::kick(array(1, 0), 1);
    self flowgraph::kick(array(0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xa7f1e264, Offset: 0x680
// Size: 0x9c
function sequence3(x) {
    self flowgraph::kick(array(1, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x210dc84a, Offset: 0x728
// Size: 0xcc
function sequence4(x) {
    self flowgraph::kick(array(1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x6391e3e5, Offset: 0x800
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
// Checksum 0x211c9cc7, Offset: 0x930
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
// Checksum 0x8144b3f2, Offset: 0xa98
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
// Checksum 0xb1591482, Offset: 0xc38
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

#namespace flowgraph_entity;

// Namespace flowgraph_entity/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x9ac06663, Offset: 0xe10
// Size: 0x12
function isentitydefinedfunc(e_entity) {
    return isdefined(e_entity);
}

// Namespace flowgraph_entity/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xcca6c9d7, Offset: 0xe30
// Size: 0x1a
function getentityorigin(e_entity) {
    return e_entity.origin;
}

// Namespace flowgraph_entity/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xe352f6e0, Offset: 0xe58
// Size: 0x1a
function getentityangles(e_entity) {
    return e_entity.angles;
}

// Namespace flowgraph_entity/flowgraph_shared
// Params 12, eflags: 0x0
// Checksum 0x48318b08, Offset: 0xe80
// Size: 0x2f2
function lerpshaderconstantovertime(x, e_entity, i_script_vector, f_start_x, f_start_y, f_start_z, f_start_w, f_end_x, f_end_y, f_end_z, f_end_w, f_time) {
    e_entity endon(#"death");
    e_entity util::waittill_dobj(self.owner.localclientnum);
    if (!isdefined(e_entity)) {
        return;
    }
    if (!isdefined(f_start_x)) {
        f_start_x = 0;
    }
    if (!isdefined(f_start_y)) {
        f_start_y = 0;
    }
    if (!isdefined(f_start_z)) {
        f_start_z = 0;
    }
    if (!isdefined(f_start_w)) {
        f_start_w = 0;
    }
    if (!isdefined(f_end_x)) {
        f_end_x = 0;
    }
    if (!isdefined(f_end_y)) {
        f_end_y = 0;
    }
    if (!isdefined(f_end_z)) {
        f_end_z = 0;
    }
    if (!isdefined(f_end_w)) {
        f_end_w = 0;
    }
    s_timer = util::new_timer(self.owner.localclientnum);
    do {
        util::server_wait(self.owner.localclientnum, 0.11);
        n_current_time = s_timer util::get_time_in_seconds();
        n_lerp_val = n_current_time / f_time;
        n_delta_val_x = lerpfloat(f_start_x, f_end_x, n_lerp_val);
        n_delta_val_y = lerpfloat(f_start_y, f_end_y, n_lerp_val);
        n_delta_val_z = lerpfloat(f_start_z, f_end_z, n_lerp_val);
        n_delta_val_w = lerpfloat(f_start_w, f_end_w, n_lerp_val);
        e_entity mapshaderconstant(self.owner.localclientnum, 0, "scriptVector" + i_script_vector, n_delta_val_x, n_delta_val_y, n_delta_val_z, n_delta_val_w);
    } while (n_current_time < f_time);
}

#namespace flowgraph_trigger;

// Namespace flowgraph_trigger/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x772fa265, Offset: 0x1180
// Size: 0x98
function ontriggerentered(x, e_trigger) {
    e_trigger endon(#"death");
    while (true) {
        waitresult = e_trigger waittill("trigger");
        e_entity = waitresult.activator;
        self flowgraph::kick(array(1, e_entity));
    }
}

#namespace flowgraph_fx;

// Namespace flowgraph_fx/flowgraph_shared
// Params 6, eflags: 0x0
// Checksum 0x4dd67f0a, Offset: 0x1220
// Size: 0x6c
function playfxatposition(x, fx_effect, v_position, v_forward, v_up, i_time) {
    playfx(self.owner.localclientnum, fx_effect, v_position, v_forward, v_up, i_time);
}

// Namespace flowgraph_fx/flowgraph_shared
// Params 4, eflags: 0x0
// Checksum 0x25e591f4, Offset: 0x1298
// Size: 0x54
function playfxontagfunc(x, e_entity, fx_effect, str_tagname) {
    playfxontag(self.owner.localclientnum, fx_effect, e_entity, str_tagname);
}

#namespace flowgraph_util;

// Namespace flowgraph_util/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0x69b4ff99, Offset: 0x12f8
// Size: 0x1c
function onflowgraphrun() {
    self.owner waittill("flowgraph_run");
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x266620f4, Offset: 0x1320
// Size: 0x1e
function waitfunc(x, f_seconds) {
    wait f_seconds;
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xbc8c7c59, Offset: 0x1348
// Size: 0x10
function createthread(x) {
    return true;
}

#namespace flowgraph_random;

// Namespace flowgraph_random/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x96bfa13f, Offset: 0x1360
// Size: 0x2a
function randomfloatinrangefunc(f_min, f_max) {
    return randomfloatrange(f_min, f_max);
}

// Namespace flowgraph_random/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0x7b614d41, Offset: 0x1398
// Size: 0x5a
function randomunitvector() {
    return vectornormalize((randomfloat(1), randomfloat(1), randomfloat(1)));
}

#namespace flowgraph_math;

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xe292b02f, Offset: 0x1400
// Size: 0x1e
function vectormultiply(v_vector, f_scalar) {
    return v_vector * f_scalar;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x8afc8cc1, Offset: 0x1428
// Size: 0x1e
function vectoradd(v_1, v_2) {
    return v_1 + v_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xace93172, Offset: 0x1450
// Size: 0x1e
function vectorsubtract(v_1, v_2) {
    return v_1 - v_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x40921ebf, Offset: 0x1478
// Size: 0x16
function vectornegate(v) {
    return v * -1;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x8e1a8a51, Offset: 0x1498
// Size: 0x2a
function vectordotfunc(v_1, v_2) {
    return vectordot(v_1, v_2);
}

#namespace flowgraph_scene;

// Namespace flowgraph_scene/flowgraph_shared
// Params 4, eflags: 0x0
// Checksum 0x1b12346, Offset: 0x14d0
// Size: 0x8c
function playscenefunc(x, e_entity, sb_name, b_thread) {
    target = e_entity;
    if (!isdefined(target)) {
        target = level;
    }
    if (b_thread) {
        target thread scene::play(sb_name);
        return;
    }
    target scene::play(sb_name);
}

#namespace flowgraph_lighting;

// Namespace flowgraph_lighting/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0x560e6585, Offset: 0x1568
// Size: 0x12
function getlightingstatefunc() {
    return getlightingstate();
}

