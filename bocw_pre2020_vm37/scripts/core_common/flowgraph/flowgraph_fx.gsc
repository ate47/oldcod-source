#using scripts\core_common\exploder_shared;

#namespace flowgraph_fx;

// Namespace flowgraph_fx/flowgraph_fx
// Params 5, eflags: 0x0
// Checksum 0x850a2b8f, Offset: 0x68
// Size: 0x50
function playfxatposition(*x, fx_effect, v_position, v_forward, v_up) {
    playfx(fx_effect, v_position, v_forward, v_up);
    return true;
}

// Namespace flowgraph_fx/flowgraph_fx
// Params 6, eflags: 0x0
// Checksum 0x267e5a3e, Offset: 0xc0
// Size: 0x58
function function_f4373d13(*x, fx_effect, v_offset, v_forward, v_up, var_a1a2ff27) {
    playfxoncamera(fx_effect, v_offset, v_forward, v_up, var_a1a2ff27);
    return true;
}

#namespace namespace_84ba1809;

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x248e2d0, Offset: 0x120
// Size: 0x30
function playexploder(*x, str_name) {
    exploder::exploder(str_name);
    return true;
}

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0xcf2743a5, Offset: 0x158
// Size: 0x30
function stopexploder(*x, str_name) {
    exploder::stop_exploder(str_name);
    return true;
}

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x5cef0bf0, Offset: 0x190
// Size: 0x30
function killexploder(*x, str_name) {
    exploder::kill_exploder(str_name);
    return true;
}

