#using scripts\core_common\exploder_shared;

#namespace flowgraph_fx;

// Namespace flowgraph_fx/flowgraph_fx
// Params 5, eflags: 0x0
// Checksum 0x1f5da07c, Offset: 0x70
// Size: 0x50
function playfxatposition(x, fx_effect, v_position, v_forward, v_up) {
    playfx(fx_effect, v_position, v_forward, v_up);
    return true;
}

// Namespace flowgraph_fx/flowgraph_fx
// Params 6, eflags: 0x0
// Checksum 0x49721bf5, Offset: 0xc8
// Size: 0x60
function function_ddb262f5(x, fx_effect, v_offset, v_forward, v_up, var_ff19846d) {
    playfxoncamera(fx_effect, v_offset, v_forward, v_up, var_ff19846d);
    return true;
}

#namespace namespace_76cc86fd;

// Namespace namespace_76cc86fd/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0xb2ed3f48, Offset: 0x130
// Size: 0x30
function playexploder(x, str_name) {
    exploder::exploder(str_name);
    return true;
}

// Namespace namespace_76cc86fd/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x5c197f6e, Offset: 0x168
// Size: 0x30
function stopexploder(x, str_name) {
    exploder::stop_exploder(str_name);
    return true;
}

// Namespace namespace_76cc86fd/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x55e51a5c, Offset: 0x1a0
// Size: 0x30
function killexploder(x, str_name) {
    exploder::kill_exploder(str_name);
    return true;
}

