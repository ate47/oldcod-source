#using scripts\core_common\flowgraph\flowgraph_core;

#namespace flowgraph_entity;

// Namespace flowgraph_entity/flowgraph_entity
// Params 1, eflags: 0x0
// Checksum 0xadf664de, Offset: 0x68
// Size: 0x10
function isentitydefinedfunc(e_entity) {
    return isdefined(e_entity);
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 1, eflags: 0x0
// Checksum 0x5ceae9e6, Offset: 0x80
// Size: 0x16
function getentityorigin(e_entity) {
    return e_entity.origin;
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 1, eflags: 0x0
// Checksum 0xcba6144e, Offset: 0xa0
// Size: 0x16
function getentityangles(e_entity) {
    return e_entity.angles;
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 1, eflags: 0x0
// Checksum 0x56556f48, Offset: 0xc0
// Size: 0x28
function onentityspawned(e_entity) {
    e_entity waittill(#"spawned");
    return true;
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 2, eflags: 0x0
// Checksum 0x36edc3f0, Offset: 0xf0
// Size: 0xd8
function onentitydamaged(*x, e_entity) {
    e_entity endon(#"death");
    while (true) {
        waitresult = e_entity waittill(#"damage");
        self flowgraph::kick(array(1, e_entity, waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.model_name, waitresult.tag_name, waitresult.part_name, waitresult.weapon, waitresult.flags));
    }
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 2, eflags: 0x0
// Checksum 0xad009e38, Offset: 0x1d0
// Size: 0x20
function function_fd19ef53(e_entity, str_field) {
    return e_entity.(str_field);
}

// Namespace flowgraph_entity/flowgraph_entity
// Params 4, eflags: 0x0
// Checksum 0x7682c155, Offset: 0x1f8
// Size: 0x38
function function_7e40ae2d(*x, e_entity, str_field, var_value) {
    e_entity.(str_field) = var_value;
    return true;
}

