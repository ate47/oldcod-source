#using scripts\core_common\callbacks_shared;
#using scripts\wz_common\util;

#namespace death_circle;

// Namespace death_circle/death_circle
// Params 0, eflags: 0x1 linked
// Checksum 0x9f177856, Offset: 0xf8
// Size: 0xf4
function init_vo() {
    callback::add_callback(#"hash_7ec09c8f8151205c", &function_e8c1f9d2);
    callback::add_callback(#"hash_3ab90c4405f67276", &function_a0fd3c83);
    callback::add_callback(#"hash_77fdc4459f2f1e35", &function_465ef407);
    callback::add_callback(#"hash_3cadee0b88ef66a2", &function_1bbc8595);
    callback::add_callback(#"hash_166e273d927bf6a3", &function_dce81333);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x1 linked
// Checksum 0x4188d081, Offset: 0x1f8
// Size: 0x4c
function function_e8c1f9d2() {
    if (!is_true(getgametypesetting(#"hash_6873fc00b59bcd39"))) {
        util::function_8076d591("warCircleDetectedFirst");
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x1 linked
// Checksum 0x1521da35, Offset: 0x250
// Size: 0x1c
function function_a0fd3c83() {
    util::function_8076d591("warCircleDetectedLast");
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x1 linked
// Checksum 0x720535f6, Offset: 0x278
// Size: 0x1c
function function_465ef407() {
    util::function_8076d591("warCircleDetected");
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x1 linked
// Checksum 0xa870f86b, Offset: 0x2a0
// Size: 0x1c
function function_1bbc8595() {
    util::function_8076d591("warCircleCollapseImminent");
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x1 linked
// Checksum 0xce750b0e, Offset: 0x2c8
// Size: 0x1c
function function_dce81333() {
    util::function_8076d591("warCircleCollapseOccurring");
}

