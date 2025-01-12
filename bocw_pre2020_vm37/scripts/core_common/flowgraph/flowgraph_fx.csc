#using scripts\core_common\exploder_shared;
#using scripts\core_common\util_shared;

#namespace flowgraph_fx;

// Namespace flowgraph_fx/flowgraph_fx
// Params 6, eflags: 0x0
// Checksum 0x5c877359, Offset: 0x70
// Size: 0x60
function playfxatposition(*x, fx_effect, v_position, v_forward, v_up, i_time) {
    playfx(self.owner.localclientnum, fx_effect, v_position, v_forward, v_up, i_time);
    return true;
}

// Namespace flowgraph_fx/flowgraph_fx
// Params 4, eflags: 0x0
// Checksum 0x84ff01a1, Offset: 0xd8
// Size: 0x50
function playfxontagfunc(*x, e_entity, fx_effect, str_tagname) {
    util::playfxontag(self.owner.localclientnum, fx_effect, e_entity, str_tagname);
    return true;
}

// Namespace flowgraph_fx/flowgraph_fx
// Params 6, eflags: 0x0
// Checksum 0x79e0ef00, Offset: 0x130
// Size: 0x60
function function_f4373d13(*x, fx_effect, v_offset, v_forward, v_up, i_time) {
    playfxoncamera(self.owner.localclientnum, fx_effect, v_offset, v_forward, v_up, i_time);
    return true;
}

#namespace namespace_84ba1809;

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x687e9e2d, Offset: 0x198
// Size: 0x30
function playexploder(*x, str_name) {
    exploder::exploder(str_name);
    return true;
}

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0xaa857f60, Offset: 0x1d0
// Size: 0x30
function stopexploder(*x, str_name) {
    exploder::stop_exploder(str_name);
    return true;
}

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x4442634a, Offset: 0x208
// Size: 0x30
function killexploder(*x, str_name) {
    exploder::kill_exploder(str_name);
    return true;
}

