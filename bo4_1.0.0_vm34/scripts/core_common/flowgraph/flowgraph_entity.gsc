#using scripts\core_common\flowgraph\flowgraph_core;

#namespace flowgraph_entity;

// Namespace flowgraph_entity/flowgraph_entity
// Params 1, eflags: 0x0
// Checksum 0x619d0783, Offset: 0x70
// Size: 0x10
function isentitydefinedfunc(e_entity) {
    return isdefined(e_entity);
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 1, eflags: 0x0
// Checksum 0x739cd366, Offset: 0x88
// Size: 0x16
function getentityorigin(e_entity) {
    return e_entity.origin;
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 1, eflags: 0x0
// Checksum 0xb5d046b4, Offset: 0xa8
// Size: 0x16
function getentityangles(e_entity) {
    return e_entity.angles;
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 1, eflags: 0x0
// Checksum 0x539574ab, Offset: 0xc8
// Size: 0x28
function onentityspawned(e_entity) {
    e_entity waittill(#"spawned");
    return true;
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 2, eflags: 0x0
// Checksum 0x817bbf40, Offset: 0xf8
// Size: 0xf8
function onentitydamaged(x, e_entity) {
    e_entity endon(#"death");
    while (true) {
        waitresult = e_entity waittill(#"damage");
        self flowgraph::kick(array(1, e_entity, waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.model_name, waitresult.tag_name, waitresult.part_name, waitresult.weapon, waitresult.flags));
    }
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 2, eflags: 0x0
// Checksum 0x1601dc21, Offset: 0x1f8
// Size: 0x20
function function_2d404f9e(e_entity, str_field) {
    return e_entity.(str_field);
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 4, eflags: 0x0
// Checksum 0x12892486, Offset: 0x220
// Size: 0x3a
function function_2604bd3a(x, e_entity, str_field, var_value) {
    e_entity.(str_field) = var_value;
    return true;
}

