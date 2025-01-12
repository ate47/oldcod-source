#using script_cb32d07c95e5628;
#using scripts\core_common\struct;

#namespace item_spawn_group;

// Namespace item_spawn_group/item_spawn_groups
// Params 2, eflags: 0x0
// Checksum 0x8b6f5c80, Offset: 0x78
// Size: 0x64
function setup(seedvalue, reset = 1) {
    if (!namespace_f68e9756::is_enabled()) {
        return;
    }
    function_ea0f3fff(seedvalue);
    namespace_f68e9756::setup_groups(reset);
}

