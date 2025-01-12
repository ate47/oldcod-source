#using script_68c78107b4aa059c;
#using scripts\core_common\struct;

#namespace item_spawn_group;

// Namespace item_spawn_group/item_spawn_groups
// Params 3, eflags: 0x0
// Checksum 0xe46b9f6c, Offset: 0x78
// Size: 0x7c
function setup(localclientnum, seedvalue, reset = 1) {
    if (!namespace_f68e9756::is_enabled()) {
        return;
    }
    level.var_fa0a1c01 = [];
    function_ea0f3fff(seedvalue);
    namespace_f68e9756::setup_groups(reset);
}

