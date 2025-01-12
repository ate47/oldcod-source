#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace namespace_4914de7c;

// Namespace namespace_4914de7c/level_init
// Params 1, eflags: 0x40
// Checksum 0xfc4a866, Offset: 0xa8
// Size: 0x9c
function event_handler[level_init] main(*eventstruct) {
    if (util::get_map_name() !== "wz_russia") {
        return;
    }
    level.var_2fc9cbf0 = 10;
    callback::add_callback(#"hash_17028f0b9883e5be", &function_386821d6);
    callback::add_callback(#"objective_ended", &function_b1eb7f05);
}

// Namespace namespace_4914de7c/namespace_4914de7c
// Params 1, eflags: 0x0
// Checksum 0xa0043fa6, Offset: 0x150
// Size: 0x104
function function_386821d6(*eventstruct) {
    if (level.var_7d45d0d4.activeobjective.content_script_name === "holdout") {
        clientfield::set("set_objective_fog", 2);
        level.var_2fc9cbf0 = 10;
        return;
    }
    if (level.var_2fc9cbf0 > randomint(100) || getdvarint(#"hash_565a7fdaf4a950da", 0)) {
        clientfield::set("set_objective_fog", 1);
        level.var_2fc9cbf0 = 10;
        return;
    }
    level.var_2fc9cbf0 += 15;
}

// Namespace namespace_4914de7c/namespace_4914de7c
// Params 1, eflags: 0x0
// Checksum 0x12712fc6, Offset: 0x260
// Size: 0x24
function function_b1eb7f05(*eventstruct) {
    clientfield::set("set_objective_fog", 0);
}

