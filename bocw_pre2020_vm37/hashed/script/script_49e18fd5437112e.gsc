#using script_152c3f4ffef9e588;
#using script_c8d806d2487b617;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace namespace_2b1568cc;

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x6
// Checksum 0x95b5f397, Offset: 0xc0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_380b7703a79220e8", &function_70a657d8, undefined, undefined, #"radiation");
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0x1ad0a948, Offset: 0x110
// Size: 0x2c
function private function_70a657d8() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    function_d90ea0e7();
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x1 linked
// Checksum 0xa26afd07, Offset: 0x148
// Size: 0x104
function function_d90ea0e7() {
    radiation::function_d90ea0e7(#"hash_668c27c4f08f8d26", &function_41d40455, &function_c11b3d17);
    radiation::function_d90ea0e7(#"hash_3d2df04e4fff88fc", &function_b3c2eb77, &function_b375f04e);
    radiation::function_d90ea0e7(#"hash_552b16be317b93d0", &function_3df85b7, &function_3213dd79);
    radiation::function_d90ea0e7(#"hash_4ae21267c92fe408", &function_e1e646f0, &function_a6beb2ea);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0x5484b7ee, Offset: 0x258
// Size: 0x2c
function private function_41d40455() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_ads", 0);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0xd71f7463, Offset: 0x290
// Size: 0x34
function private function_c11b3d17() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_ads", 1);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0x38f79997, Offset: 0x2d0
// Size: 0x2c
function private function_b3c2eb77() {
    self val::set(#"hash_668c27c4f08f8d26", "health_regen", 0);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0xa9477c44, Offset: 0x308
// Size: 0x34
function private function_b375f04e() {
    self val::set(#"hash_668c27c4f08f8d26", "health_regen", 1);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0xf860d83b, Offset: 0x348
// Size: 0x2c
function private function_3df85b7() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_melee", 0);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0x2e1b4597, Offset: 0x380
// Size: 0x34
function private function_3213dd79() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_melee", 1);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0xf328e54b, Offset: 0x3c0
// Size: 0x2c
function private function_e1e646f0() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_sprint", 0);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x5 linked
// Checksum 0x53225bbf, Offset: 0x3f8
// Size: 0x34
function private function_a6beb2ea() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_sprint", 1);
}

