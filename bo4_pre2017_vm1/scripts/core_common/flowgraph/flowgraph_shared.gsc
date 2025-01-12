#using scripts/core_common/flag_shared;
#using scripts/core_common/flowgraph/flowgraph_core;
#using scripts/core_common/scene_shared;

#namespace flowgraph_logic;

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x773ccc0f, Offset: 0x130
// Size: 0x32
function iffunc(x, b) {
    return array(b, !b);
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x4735105f, Offset: 0x170
// Size: 0x4a
function orfunc(x, b_a, b_b) {
    return array(b_a || b_b, !(b_a || b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xf53213f5, Offset: 0x1c8
// Size: 0x4a
function andfunc(x, b_a, b_b) {
    return array(b_a && b_b, !(b_a && b_b));
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xed604a9e, Offset: 0x220
// Size: 0x12
function notfunc(b_value) {
    return !b_value;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x72dd7010, Offset: 0x240
// Size: 0x1e
function integerlessthan(i_a, i_b) {
    return i_a < i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xd3dfb6f5, Offset: 0x268
// Size: 0x1e
function integerlessthanorequal(i_a, i_b) {
    return i_a <= i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x6f876616, Offset: 0x290
// Size: 0x1e
function integergreaterthan(i_a, i_b) {
    return i_a > i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x5e46e4e2, Offset: 0x2b8
// Size: 0x1e
function integergreaterthanorequal(i_a, i_b) {
    return i_a >= i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xc7a6e4c, Offset: 0x2e0
// Size: 0x1e
function integersequals(i_a, i_b) {
    return i_a == i_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xcdd6aa4f, Offset: 0x308
// Size: 0x1e
function floatlessthan(f_a, f_b) {
    return f_a < f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x3804151a, Offset: 0x330
// Size: 0x1e
function floatlessthanorequal(f_a, f_b) {
    return f_a <= f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xd4773cd4, Offset: 0x358
// Size: 0x1e
function floatgreaterthan(f_a, f_b) {
    return f_a > f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x6f6516e9, Offset: 0x380
// Size: 0x1e
function floatgreaterthanorequal(f_a, f_b) {
    return f_a >= f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x7f09b9db, Offset: 0x3a8
// Size: 0x1e
function floatsequal(f_a, f_b) {
    return f_a == f_b;
}

// Namespace flowgraph_logic/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xb8b7ec75, Offset: 0x3d0
// Size: 0x1e
function stringsequal(str_a, str_b) {
    return str_a == str_b;
}

#namespace flowgraph_loops;

// Namespace flowgraph_loops/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0xf827e5f7, Offset: 0x3f8
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
// Checksum 0xadef45ee, Offset: 0x4a8
// Size: 0xb2
function foreachloop(x, a_items) {
    foreach (item in a_items) {
        self flowgraph::kick(array(1, item), 1);
    }
}

// Namespace flowgraph_loops/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xdeef05d9, Offset: 0x568
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
// Checksum 0x52462d92, Offset: 0x5e8
// Size: 0x6c
function sequence2(x) {
    self flowgraph::kick(array(1, 0), 1);
    self flowgraph::kick(array(0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xd7282811, Offset: 0x660
// Size: 0x9c
function sequence3(x) {
    self flowgraph::kick(array(1, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xc65311f3, Offset: 0x708
// Size: 0xcc
function sequence4(x) {
    self flowgraph::kick(array(1, 0, 0, 0), 1);
    self flowgraph::kick(array(0, 1, 0, 0), 1);
    self flowgraph::kick(array(0, 0, 1, 0), 1);
    self flowgraph::kick(array(0, 0, 0, 1), 1);
}

// Namespace flowgraph_sequence/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x76edbfe, Offset: 0x7e0
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
// Checksum 0x77c54c09, Offset: 0x910
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
// Checksum 0x81993eeb, Offset: 0xa78
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
// Checksum 0x318f4e36, Offset: 0xc18
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
// Checksum 0x31e9ee39, Offset: 0xdf0
// Size: 0x12
function isentitydefinedfunc(e_entity) {
    return isdefined(e_entity);
}

// Namespace flowgraph_entity/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xcbaf80d9, Offset: 0xe10
// Size: 0x1a
function getentityorigin(e_entity) {
    return e_entity.origin;
}

// Namespace flowgraph_entity/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x891dca4d, Offset: 0xe38
// Size: 0x1a
function getentityangles(e_entity) {
    return e_entity.angles;
}

// Namespace flowgraph_entity/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x5afefb71, Offset: 0xe60
// Size: 0x20
function onentityspawned(e_entity) {
    e_entity waittill("spawned");
    return true;
}

// Namespace flowgraph_entity/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xba42a0b6, Offset: 0xe88
// Size: 0xf0
function onentitydamaged(x, e_entity) {
    e_entity endon(#"death");
    while (true) {
        waitresult = e_entity waittill("damage");
        self flowgraph::kick(array(1, e_entity, waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.model_name, waitresult.tag_name, waitresult.part_name, waitresult.weapon, waitresult.flags));
    }
}

#namespace flowgraph_trigger;

// Namespace flowgraph_trigger/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xfec6df8e, Offset: 0xf80
// Size: 0x80
function ontriggerentered(x, e_trigger) {
    e_trigger endon(#"death");
    while (true) {
        waitresult = e_trigger waittill("trigger");
        self flowgraph::kick(array(1, waitresult.activator));
    }
}

#namespace flowgraph_fx;

// Namespace flowgraph_fx/flowgraph_shared
// Params 5, eflags: 0x0
// Checksum 0x8673a748, Offset: 0x1008
// Size: 0x4c
function playfxatposition(x, fx_effect, v_position, v_forward, v_up) {
    playfx(fx_effect, v_position, v_forward, v_up);
}

#namespace flowgraph_sound;

// Namespace flowgraph_sound/flowgraph_shared
// Params 3, eflags: 0x0
// Checksum 0x4bef9e0b, Offset: 0x1060
// Size: 0x34
function playsoundaliasatposition(x, snd_name, v_position) {
    playsoundatposition(snd_name, v_position);
}

#namespace flowgraph_spawn;

// Namespace flowgraph_spawn/flowgraph_shared
// Params 6, eflags: 0x0
// Checksum 0xdb84986c, Offset: 0x10a0
// Size: 0x82
function spawnentityfromspawner(x, sp_spawner, str_targetname, b_force_spawn, b_make_room, b_infinite_spawn) {
    e_spawned = sp_spawner spawnfromspawner(str_targetname, b_force_spawn, b_make_room, b_infinite_spawn);
    return array(isdefined(e_spawned), e_spawned);
}

#namespace flowgraph_player;

// Namespace flowgraph_player/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xda84a51a, Offset: 0x1130
// Size: 0x2a
function ifplayer(x, e_entity) {
    return isplayer(e_entity);
}

#namespace flowgraph_util;

// Namespace flowgraph_util/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0xc6e65c6e, Offset: 0x1168
// Size: 0x1c
function onflowgraphrun() {
    self.owner waittill("flowgraph_run");
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xc3245f3a, Offset: 0x1190
// Size: 0x1e
function waitfunc(x, f_seconds) {
    wait f_seconds;
    return true;
}

// Namespace flowgraph_util/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0x2d1fb1c8, Offset: 0x11b8
// Size: 0x10
function createthread(x) {
    return true;
}

#namespace flowgraph_random;

// Namespace flowgraph_random/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0x13717444, Offset: 0x11d0
// Size: 0x2a
function randomfloatinrangefunc(f_min, f_max) {
    return randomfloatrange(f_min, f_max);
}

// Namespace flowgraph_random/flowgraph_shared
// Params 0, eflags: 0x0
// Checksum 0x4bbfd70e, Offset: 0x1208
// Size: 0x5a
function randomunitvector() {
    return vectornormalize((randomfloat(1), randomfloat(1), randomfloat(1)));
}

#namespace flowgraph_math;

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xd78a583e, Offset: 0x1270
// Size: 0x1e
function vectormultiply(v_vector, f_scalar) {
    return v_vector * f_scalar;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xe6f4a9ce, Offset: 0x1298
// Size: 0x1e
function vectoradd(v_1, v_2) {
    return v_1 + v_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xd413fa07, Offset: 0x12c0
// Size: 0x1e
function vectorsubtract(v_1, v_2) {
    return v_1 - v_2;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 1, eflags: 0x0
// Checksum 0xdc64c330, Offset: 0x12e8
// Size: 0x16
function vectornegate(v) {
    return v * -1;
}

// Namespace flowgraph_math/flowgraph_shared
// Params 2, eflags: 0x0
// Checksum 0xfe25f62e, Offset: 0x1308
// Size: 0x2a
function vectordotfunc(v_1, v_2) {
    return vectordot(v_1, v_2);
}

#namespace flowgraph_scene;

// Namespace flowgraph_scene/flowgraph_shared
// Params 4, eflags: 0x0
// Checksum 0x5fbb25f2, Offset: 0x1340
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

