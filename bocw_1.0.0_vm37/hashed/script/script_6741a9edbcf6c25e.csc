#using script_78825cbb1ab9f493;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_insertion;

#namespace namespace_2938acdc;

// Namespace namespace_2938acdc/namespace_2938acdc
// Params 0, eflags: 0x0
// Checksum 0xc27a9d50, Offset: 0xa0
// Size: 0xa4
function init() {
    level.var_db91e97c = 1;
    namespace_17baa64d::init();
    if (is_true(getgametypesetting(#"hash_6eef7868c4f5ddbc"))) {
        clientfield::register_clientuimodel("squad_wipe_tokens.count", #"hash_8155b36904833e4", #"count", 1, 4, "int", undefined, 0, 0);
    }
}

