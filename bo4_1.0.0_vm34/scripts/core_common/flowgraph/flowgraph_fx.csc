#using scripts\core_common\exploder_shared;
#using scripts\core_common\util_shared;

#namespace flowgraph_fx;

// Namespace flowgraph_fx/flowgraph_fx
// Params 6, eflags: 0x0
// Checksum 0x5c81a905, Offset: 0x78
// Size: 0x68
function playfxatposition(x, fx_effect, v_position, v_forward, v_up, i_time) {
    playfx(self.owner.localclientnum, fx_effect, v_position, v_forward, v_up, i_time);
    return true;
}

// Namespace flowgraph_fx/flowgraph_fx
// Params 4, eflags: 0x0
// Checksum 0x66e40505, Offset: 0xe8
// Size: 0x50
function playfxontagfunc(x, e_entity, fx_effect, str_tagname) {
    util::playfxontag(self.owner.localclientnum, fx_effect, e_entity, str_tagname);
    return true;
}

// Namespace flowgraph_fx/flowgraph_fx
// Params 6, eflags: 0x0
// Checksum 0x662d545f, Offset: 0x140
// Size: 0x68
function function_ddb262f5(x, fx_effect, v_offset, v_forward, v_up, i_time) {
    playfxoncamera(self.owner.localclientnum, fx_effect, v_offset, v_forward, v_up, i_time);
    return true;
}

#namespace namespace_76cc86fd;

// Namespace namespace_76cc86fd/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0xe7e4bb49, Offset: 0x1b0
// Size: 0x30
function playexploder(x, str_name) {
    exploder::exploder(str_name);
    return true;
}

// Namespace namespace_76cc86fd/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x1de0dc73, Offset: 0x1e8
// Size: 0x30
function stopexploder(x, str_name) {
    exploder::stop_exploder(str_name);
    return true;
}

// Namespace namespace_76cc86fd/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0xcecbd448, Offset: 0x220
// Size: 0x30
function killexploder(x, str_name) {
    exploder::kill_exploder(str_name);
    return true;
}

