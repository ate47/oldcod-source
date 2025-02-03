#using script_152c3f4ffef9e588;
#using script_c8d806d2487b617;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace namespace_2b1568cc;

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x6
// Checksum 0xd73742ee, Offset: 0xc0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_380b7703a79220e8", &preinit, undefined, undefined, #"radiation");
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0x466404af, Offset: 0x110
// Size: 0x2c
function private preinit() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    function_d90ea0e7();
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x0
// Checksum 0xc3de50f0, Offset: 0x148
// Size: 0x104
function function_d90ea0e7() {
    radiation::function_d90ea0e7(#"hash_668c27c4f08f8d26", &function_41d40455, &function_c11b3d17);
    radiation::function_d90ea0e7(#"hash_3d2df04e4fff88fc", &function_b3c2eb77, &function_b375f04e);
    radiation::function_d90ea0e7(#"hash_552b16be317b93d0", &function_3df85b7, &function_3213dd79);
    radiation::function_d90ea0e7(#"hash_4ae21267c92fe408", &function_e1e646f0, &function_a6beb2ea);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0x1fa12dd7, Offset: 0x258
// Size: 0x2c
function private function_41d40455() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_ads", 0);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0xe3b0eab0, Offset: 0x290
// Size: 0x34
function private function_c11b3d17() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_ads", 1);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0xe40073d9, Offset: 0x2d0
// Size: 0x2c
function private function_b3c2eb77() {
    self val::set(#"hash_668c27c4f08f8d26", "health_regen", 0);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0x6d7ddf59, Offset: 0x308
// Size: 0x34
function private function_b375f04e() {
    self val::set(#"hash_668c27c4f08f8d26", "health_regen", 1);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0xfdb900f7, Offset: 0x348
// Size: 0x2c
function private function_3df85b7() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_melee", 0);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0x628e6269, Offset: 0x380
// Size: 0x34
function private function_3213dd79() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_melee", 1);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0xa05ad19d, Offset: 0x3c0
// Size: 0x2c
function private function_e1e646f0() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_sprint", 0);
}

// Namespace namespace_2b1568cc/namespace_2b1568cc
// Params 0, eflags: 0x4
// Checksum 0xefc5a5a0, Offset: 0x3f8
// Size: 0x34
function private function_a6beb2ea() {
    self val::set(#"hash_668c27c4f08f8d26", "allow_sprint", 1);
}

