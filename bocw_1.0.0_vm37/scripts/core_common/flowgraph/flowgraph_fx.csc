#using scripts\core_common\exploder_shared;
#using scripts\core_common\util_shared;

#namespace flowgraph_fx;

// Namespace flowgraph_fx/flowgraph_fx
// Params 6, eflags: 0x0
// Checksum 0x31c2e99c, Offset: 0x70
// Size: 0x60
function playfxatposition(*x, fx_effect, v_position, v_forward, v_up, i_time) {
    playfx(self.owner.localclientnum, fx_effect, v_position, v_forward, v_up, i_time);
    return true;
}

// Namespace flowgraph_fx/flowgraph_fx
// Params 4, eflags: 0x0
// Checksum 0x49dc8931, Offset: 0xd8
// Size: 0x50
function playfxontagfunc(*x, e_entity, fx_effect, str_tagname) {
    util::playfxontag(self.owner.localclientnum, fx_effect, e_entity, str_tagname);
    return true;
}

// Namespace flowgraph_fx/flowgraph_fx
// Params 6, eflags: 0x0
// Checksum 0xa187edc9, Offset: 0x130
// Size: 0x60
function function_f4373d13(*x, fx_effect, v_offset, v_forward, v_up, i_time) {
    playfxoncamera(self.owner.localclientnum, fx_effect, v_offset, v_forward, v_up, i_time);
    return true;
}

#namespace namespace_84ba1809;

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x8e3935ab, Offset: 0x198
// Size: 0x30
function playexploder(*x, str_name) {
    exploder::exploder(str_name);
    return true;
}

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0x6b46c66e, Offset: 0x1d0
// Size: 0x30
function stopexploder(*x, str_name) {
    exploder::stop_exploder(str_name);
    return true;
}

// Namespace namespace_84ba1809/flowgraph_fx
// Params 2, eflags: 0x0
// Checksum 0xa262b8fe, Offset: 0x208
// Size: 0x30
function killexploder(*x, str_name) {
    exploder::kill_exploder(str_name);
    return true;
}

