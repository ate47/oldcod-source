#using script_101d8280497ff416;
#using script_680dddbda86931fa;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;

#namespace namespace_f0884ae5;

// Namespace namespace_f0884ae5/namespace_1d9375fc
// Params 3, eflags: 0x1 linked
// Checksum 0x25cae861, Offset: 0x80
// Size: 0xcc
function setup(*localclientnum, seedvalue, reset = 1) {
    if (!item_world_util::use_item_spawns()) {
        return;
    }
    level.var_8c615e33 = [];
    function_1f4464c0(seedvalue);
    println("<dev string:x38>" + seedvalue);
    if (reset) {
        level callback::callback(#"hash_11bd48298bde44a4", undefined);
    }
    namespace_65181344::setup_groups(reset);
}

